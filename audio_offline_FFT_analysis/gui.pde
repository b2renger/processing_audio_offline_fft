void setup_gui() {
  // create a new button with name 'buttonA'
  cp5.addButton("Load_Audio")
    .setValue(0)
    .setPosition(width/2-100, height*0.05)
    .setSize(200, 19)
    ;

  cp5.addSlider("number_of_bands")
    .setPosition(width/2-200, height*0.35)
    .setWidth(400)
    .setRange(10, 160) // values can range from big to small as well
    .setValue(10)
    .setNumberOfTickMarks(16)
    .setSliderMode(Slider.FLEXIBLE)
    ;

  cp5.getController("number_of_bands").getValueLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingY(20);
  cp5.getController("number_of_bands").getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE).setPaddingX(0);


  cp5.addTextfield("export_name")
    .setPosition(width/2-100, height*0.7)
    .setSize(200, 19)
    //.setFont(createFont("arial",16))
    .setAutoClear(false)
    ;
  cp5.getController("export_name").getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE).setPaddingX(0);



  cp5.addButton("Analyse_Left_Channel")
    .setValue(0)
    .setPosition(width*0.25-75, height*0.85)
    .setSize(150, 19)
    ;

  cp5.addButton("Analyse_Right_Channel")
    .setValue(0)
    .setPosition(width*0.5-75, height*0.85)
    .setSize(150, 19)
    ;

  cp5.addButton("Analyse_Joined_Channel")
    .setValue(0)
    .setPosition(width*0.75-75, height*0.85)
    .setSize(150, 19)
    ;
}
