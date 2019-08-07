
void analyzeJoin() {
  table = new Table();
  AudioSample jingle = minim.loadSample(file, 2048);

  float[] leftChannel = jingle.getChannel(AudioSample.LEFT);
  float[] rightChannel = jingle.getChannel(AudioSample.RIGHT);

  //printArray(leftChannel);
  float[] fftSamplesLeft = new float[fftSize];
  float[] fftSamplesRight = new float[fftSize];
  FFT fft = new FFT( fftSize, jingle.sampleRate() );
  fft.window(  FFT.HAMMING );

  nbands =  int(cp5.getController("number_of_bands").getValue() / 10);
  fft.logAverages( 20 + minBandwith, nbands );

  println(fft.avgSize() + " bands");

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
    int chunkSizeLeft = min( leftChannel.length - chunkStartIndex, fftSize );
    int chunkSizeRight = min( leftChannel.length - chunkStartIndex, fftSize );
    // copy first chunk into our analysis array
    System.arraycopy( leftChannel, // source of the copy
      chunkStartIndex, // index to start in the source
      fftSamplesLeft, // destination of the copy
      0, // index to copy to
      chunkSizeLeft // how many samples to copy
      );
    // if the chunk was smaller than the fftSize, we need to pad the analysis buffer with zeroes        
    if ( chunkSizeLeft < fftSize ) {
      java.util.Arrays.fill( fftSamplesLeft, chunkSizeLeft, fftSamplesLeft.length - 1, 0.0 );
    }

    fft.forward( fftSamplesLeft );
    float [] leftAVG = new float[fft.avgSize()];
    for (int i = 0; i < fft.avgSize(); ++i) {
      float amplitude = fft.getAvg(i);
      float bandDB = dB(amplitude/ fft.timeSize());
      leftAVG[i]= bandDB;
    }

    System.arraycopy( rightChannel, // source of the copy
      chunkStartIndex, // index to start in the source
      fftSamplesRight, // destination of the copy
      0, // index to copy to
      chunkSizeRight // how many samples to copy
      );
    // if the chunk was smaller than the fftSize, we need to pad the analysis buffer with zeroes        
    if ( chunkSizeRight < fftSize ) {
      java.util.Arrays.fill( fftSamplesRight, chunkSizeRight, fftSamplesRight.length - 1, 0.0 );
    }

    // now analyze this buffer

    fft.forward( fftSamplesRight );
    float [] rightAVG = new float[fft.avgSize()];
    for (int i = 0; i < fft.avgSize(); ++i) {
      float amplitude = fft.getAvg(i);
      float bandDB = dB(amplitude/ fft.timeSize());
      rightAVG[i]= bandDB;
    }

    // create and fill up a new row
    TableRow newRow = table.addRow();
    newRow.setFloat("chunk_number", chunkIdx);
    newRow.setFloat("timestamp", map(chunkIdx, 0, totalChunks, 0, jingle.length()));
    newRow.setString("channel", "JOIN");
    for (int i = 0; i < fft.avgSize(); ++i) {
      newRow.setFloat(nf(fft.getAverageCenterFrequency(i), 0, 1) + "Hz", (leftAVG[i] + rightAVG[i]) /2);
    }
  }

  jingle.close(); 


  //String[] splitstrings = split(file, '/');
  //println(split(file, '/')[splitstrings.length-1] );
  String name = cp5.get(Textfield.class, "export_name").getText() +"_" + nbands*10 +"bands"+ "_JOIN.csv";
  saveTable(table, "data/"+ name );
  println(name);
}
