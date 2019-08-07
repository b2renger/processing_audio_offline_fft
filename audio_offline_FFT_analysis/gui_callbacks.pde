
public void Load_Audio(int theValue) {
  selectInput("Select a file to process:", "fileSelected");
}

public void Analyse_Left_Channel(int theValue) {
  if (fileSelected) {
    analyzeLeft();
  }
}

public void Analyse_Right_Channel(int theValue) {
  if (fileSelected) {
    analyzeRight();
  }
}

public void Analyse_Joined_Channel(int theValue) {
  if (fileSelected) {
    analyzeJoin();
  }
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    file = selection.getAbsolutePath();
    fileSelected = true;
  }
}
