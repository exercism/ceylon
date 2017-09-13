class Error() {}

String|Error transcription(String dna) {
  return dna.fold("" of String|Error)((String|Error r,
                                       Character    c) =>   if (is Error r)
                                                          then (r)
                                                          else (switch (c)
                                                                case ('G') r + "C"
                                                                case ('C') r + "G"
                                                                case ('T') r + "A"
                                                                case ('A') r + "U"
                                                                else (Error())));
}
