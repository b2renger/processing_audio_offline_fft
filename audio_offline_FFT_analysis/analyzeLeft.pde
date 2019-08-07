
void analyzeLeft() {
  table = new Table();
  AudioSample jingle = minim.loadSample(file, 2048);

  float[] leftChannel = jingle.getChannel(AudioSample.LEFT);
  //printArray(leftChannel);
  float[] fftSamples = new float[fftSize];
  FFT fft = new FFT( fftSize, jingle.sampleRate() );
  fft.window(  FFT.HAMMING );
  nbands =  int(cp5.getController("number_of_bands").getValue() / 10);
  fft.logAverages( 20 + minBandwith, nbands );

  println(fft.avgSize());

  // now we'll analyze the samples in chunks
  int totalChunks = (leftChannel.length / fftSize) + 1;

  // prepare the table structure for each row
  table.addColumn("chunk_number");
  table.addColumn("timestamp");
  table.addColumn("channel");
  for (int j = 0; j < fft.avgSize(); ++j) {
    table.addColumn(nf(fft.getAverageCenterFrequency(j), 0, 1) + "Hz");
  }

  // analyse in chunks
  for (int chunkIdx = 0; chunkIdx < totalChunks; ++chunkIdx) {
    int chunkStartIndex = chunkIdx * fftSize;
    // the chunk size will always be fftSize, except for the 
    // last chunk, which will be however many samples are left in source
    int chunkSize = min( leftChannel.length - chunkStartIndex, fftSize );
    // copy first chunk into our analysis array
    System.arraycopy( leftChannel, // source of the copy
      chunkStartIndex, // index to start in the source
      fftSamples, // destination of the copy
      0, // index to copy to
      chunkSize // how many samples to copy
      );
    // if the chunk was smaller than the fftSize, we need to pad the analysis buffer with zeroes        
    if ( chunkSize < fftSize ) {
      java.util.Arrays.fill( fftSamples, chunkSize, fftSamples.length - 1, 0.0 );
    }

    // now analyze this buffer
    fft.forward( fftSamples );

    // create and fill up a new row
    TableRow newRow = table.addRow();
    newRow.setFloat("chunk_number", chunkIdx);
    newRow.setFloat("timestamp", map(chunkIdx, 0, totalChunks, 0, jingle.length()));
    newRow.setString("channel", "LEFT");
    for (int i = 0; i < fft.avgSize(); ++i) {
      float amplitude = fft.getAvg(i);
      float bandDB = dB(amplitude/ fft.timeSize());
      newRow.setFloat(nf(fft.getAverageCenterFrequency(i), 0, 1) + "Hz", bandDB);
    }
  }

  jingle.close(); 


  //String[] splitstrings = split(file, '/');
  //println(split(file, '/')[splitstrings.length-1] );
  String name = cp5.get(Textfield.class, "export_name").getText() +"_" + nbands*10 +"bands"+ "_LEFT.csv";
  saveTable(table, "data/"+ name);
}
