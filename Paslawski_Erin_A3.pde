/* CPSC 583 - Assignment 3 
  Author: Erin Paslawski
  Date: November 2021

  Simulating typing with visuals
*/

// size of the circles
int MAX_SIZE = 50;

// MOUSE
float mousetransparency;
color mouse_value;
float x;
float y;


// LETTERS
int letter_values[] = new int[26];
float letter_transparency[] = new float[26];
float letter_mapped_trans[] = new float[26];
int letter_pressed[] = new int[26];
int letter_size[] = new int[26];

// SPECIAL CHARS
int char_values[] = new int[13]; // !@#$%^&*(),.?
float char_transparency[] = new float[13];
float char_mapped_trans[] = new float[13];
int char_pressed[] = new int[13];
int char_size[] = new int[13];

// NUMBERS 
int num_values[] = new int [10]; // 1234567890
float num_trans[] = new float[10];
float num_mapped_trans[] = new float[10];
int num_pressed[] = new int [10];
int num_size[] = new int [10];

//SPACE  
int space_value;
float space_trans;
float space_mapped_trans;
// not going to keep track of space pessed it is used too much

// to decrease transparency
float dtrans;

// to store total text
String total_text = "";

// to track typing speed
float key_speed;
color c;

// set up window
void setup() {
  //window size
  size(1000, 800);

  background(229,229,229); // grey
  
  //mouse setup
  mousetransparency =0;
  mouse_value = color(229,229,229);
  // letter set up
  for (int i =0; i<26; i++){
    letter_transparency[i] = 0;
    letter_values[i] = 0;
    letter_mapped_trans[i] = 0;
    letter_pressed[i]=0;
    letter_size[i]=0;
  }
  // special chars set up
  for (int i =0; i<13; i++){
    char_transparency[i] = 0;
    char_values[i] = 0;
    char_mapped_trans[i] = 0; 
    char_pressed[i]=0;
    char_size[i]=0;
  }
  // numbers set up
  for (int i = 0; i <10; i++){
    num_values[i] = 0;
    num_trans[i] = 0;
    num_mapped_trans[i] = 0;
    num_pressed[i]=0;
    num_size[i]=0;
  }
  
  // space set up
  space_value = 0;
  space_trans = 0;
  space_mapped_trans = 0;
  
  // circle sizes
  width = 0;
  height = 0;
  
  // colour of text window
  c = color(229,229,229);
  
  key_speed = 0;
  dtrans = -0.01;
  smooth();
  frameRate(40);
}

void draw() {
  background(229,229,229); // grey
  noStroke(); // no outline
  
  // colour box
  if (key_speed <= 0){
    c = color(229 + (key_speed*2), 229+(key_speed*1.9), 229);
  }
  if (key_speed > 0){
    c = color(229, 229 - (key_speed*5), 229 - (key_speed*5));
  }
  fill(c);
  rectMode(CENTER);
  rect(500,600,800,325,28);
  
  // draw mouse if not transparent
  float mouse_mapped_trans = map(mousetransparency, 0, 1, 0, 255);
  fill(mouse_value, mouse_mapped_trans);
  ellipse(x, y, 70, 70);
  
  // calculate the transparency and size of the letters
  for (int i =0; i<26; i++){
    letter_mapped_trans[i] = map(letter_transparency[i], 0, 1, 0, 255);
    if (letter_size[i] < MAX_SIZE) {
      letter_size[i] = letter_pressed[i]*2;
    }
  }
  
    // calculate the transparency and size of the chars
  for (int i =0; i<13; i++){
    char_mapped_trans[i] = map(char_transparency[i], 0, 1, 0, 255);
    if (char_size[i] < MAX_SIZE) {
      char_size[i] = char_pressed[i]*2;
    }
  }  
  
  // calculate the transparency and size of the numbers
  for (int i =0; i<10; i++){
    num_mapped_trans[i] = map(num_trans[i], 0, 1, 0, 255); 
    if (num_size[i] < MAX_SIZE) {
      num_size[i] = num_pressed[i]*2;
    }
  }
  
  
  
  // text 
  textSize(40);
  fill(#3a5a5c);
  rectMode(CORNER);
  text(total_text, 100,450,800,750);

  
  // SPACE
  space_mapped_trans = map(space_trans, 0, 1, 0, 255);
  fill(space_value,space_mapped_trans);
  rect( 400, 250,  200, 50);
  
    // q = 16
  fill(letter_values[16],letter_mapped_trans[16]);
  ellipse(map(2, 0, 13, 0, 1000), 100, letter_size[16], letter_size[16]);
  // w = 22
  fill(letter_values[22],letter_mapped_trans[22]);
  ellipse(map(3, 0, 13, 0, 1000), 100, letter_size[22], letter_size[22]);
  // e = 4
  fill(letter_values[4],letter_mapped_trans[4]);
  ellipse(map(4, 0, 13, 0, 1000), 100, letter_size[4], letter_size[4]);
    // r = 17
  fill(letter_values[17],letter_mapped_trans[17]);
  ellipse(map(5, 0, 13, 0, 1000), 100, letter_size[17], letter_size[17]);
    // t = 19
  fill(letter_values[19],letter_mapped_trans[19]);
  ellipse(map(6, 0, 13, 0, 1000), 100, letter_size[19], letter_size[19]);
    // y = 24
  fill(letter_values[24],letter_mapped_trans[24]);
  ellipse(map(7, 0, 13, 0, 1000), 100, letter_size[24], letter_size[24]);
    // u= = 20
  fill(letter_values[20],letter_mapped_trans[20]);
  ellipse(map(8, 0, 13, 0, 1000), 100, letter_size[20], letter_size[20]);
    // i = 8
  fill(letter_values[8],letter_mapped_trans[8]);
  ellipse(map(9, 0, 13, 0, 1000), 100, letter_size[8], letter_size[8]);
    // o = 14
  fill(letter_values[14],letter_mapped_trans[14]);
  ellipse(map(10, 0, 13, 0, 1000), 100, letter_size[14], letter_size[14]);
    // p = 15
  fill(letter_values[15],letter_mapped_trans[15]);
  ellipse(map(11, 0, 13, 0, 1000), 100, letter_size[15], letter_size[15]);
    // a = 0
  fill(letter_values[0],letter_mapped_trans[0]);
  ellipse(map(2, 0, 12, 0, 1000), 150, letter_size[0], letter_size[0]);
    // s = 18
  fill(letter_values[18],letter_mapped_trans[18]);
  ellipse(map(3, 0, 12, 0, 1000), 150, letter_size[18], letter_size[18]);
    // d = 3
  fill(letter_values[3],letter_mapped_trans[3]);
  ellipse(map(4, 0, 12, 0, 1000), 150, letter_size[3], letter_size[3]);
    // f = 5
  fill(letter_values[5],letter_mapped_trans[5]);
  ellipse(map(5, 0, 12, 0, 1000), 150, letter_size[5], letter_size[5]);
    // g = 6
  fill(letter_values[6],letter_mapped_trans[6]);
  ellipse(map(6, 0, 12, 0, 1000), 150, letter_size[6], letter_size[6]);
    // h = 7
  fill(letter_values[7],letter_mapped_trans[7]);
  ellipse(map(7, 0, 12, 0, 1000), 150, letter_size[7], letter_size[7]);
    // j = 9
  fill(letter_values[9],letter_mapped_trans[9]);
  ellipse(map(8, 0, 12, 0, 1000), 150, letter_size[9], letter_size[9]);
    // k = 10
  fill(letter_values[10],letter_mapped_trans[10]);
  ellipse(map(9, 0, 12, 0, 1000), 150, letter_size[10], letter_size[10]);
    // l = 11
  fill(letter_values[11],letter_mapped_trans[11]);
  ellipse(map(10, 0, 12, 0, 1000), 150, letter_size[11], letter_size[11]);
    // z = 25
  fill(letter_values[25],letter_mapped_trans[25]);
  ellipse(map(3, 0, 14, 0, 1000), 200, letter_size[25], letter_size[25]);
    // x = 23
  fill(letter_values[23],letter_mapped_trans[23]);
  ellipse(map(4, 0, 14, 0, 1000), 200, letter_size[23], letter_size[23]);
    // c = 2
  fill(letter_values[2],letter_mapped_trans[2]);
  ellipse(map(5, 0, 14, 0, 1000), 200, letter_size[2], letter_size[2]);
    // v = 21
  fill(letter_values[21],letter_mapped_trans[21]);
  ellipse(map(6, 0, 14, 0, 1000), 200, letter_size[21], letter_size[21]);
    // b = 1
  fill(letter_values[1],letter_mapped_trans[1]);
  ellipse(map(7, 0, 14, 0, 1000), 200, letter_size[1], letter_size[1]);
    // n = 13
  fill(letter_values[13],letter_mapped_trans[13]);
  ellipse(map(8, 0, 14, 0, 1000), 200, letter_size[13], letter_size[13]);
    // m = 12
  fill(letter_values[12],letter_mapped_trans[12]);
  ellipse(map(9, 0, 14, 0, 1000), 200, letter_size[12],letter_size[12]);
    // ! = 0
  fill(char_values[0],char_mapped_trans[0]);
  ellipse(map(1, 0, 13, 0, 1000), 50, char_size[0], char_size[0]);  
  // @ = 1
  fill(char_values[0],char_mapped_trans[1]);
  ellipse(map(2, 0, 13, 0, 1000), 50, char_size[1], char_size[1]); 
  // # = 2
  fill(char_values[1],char_mapped_trans[2]);
  ellipse(map(3, 0, 13, 0, 1000), 50, char_size[2], char_size[2]); 
  // $= 3
  fill(char_values[0],char_mapped_trans[3]);
  ellipse(map(4, 0, 13, 0, 1000), 50, char_size[3], char_size[3]); 
  // %=4
  fill(char_values[0],char_mapped_trans[4]);
  ellipse(map(5, 0, 13, 0, 1000), 50, char_size[4], char_size[4]); 
  // ^=5
  fill(char_values[0],char_mapped_trans[5]);
  ellipse(map(6, 0, 13, 0, 1000), 50, char_size[5], char_size[5]); 
  // &=6
  fill(char_values[0],char_mapped_trans[6]);
  ellipse(map(7, 0, 13, 0, 1000), 50, char_size[6], char_size[6]); 
  // *=7
  fill(char_values[0],char_mapped_trans[7]);
  ellipse(map(8, 0, 13, 0, 1000), 50, char_size[7], char_size[7]); 
  // (=8
  fill(char_values[0],char_mapped_trans[8]);
  ellipse(map(9, 0, 13, 0, 1000), 50, char_size[8], char_size[8]); 
  // )=9
  fill(char_values[0],char_mapped_trans[9]);
  ellipse(map(10, 0, 13, 0, 1000), 50, char_size[9], char_size[9]); 
  // ,=10
  fill(char_values[0],char_mapped_trans[10]);
  ellipse(map(10, 0, 14, 0, 1000), 200, char_size[10], char_size[10]); 
  // .=11
  fill(char_values[0],char_mapped_trans[11]);
  ellipse(map(11, 0, 14, 0, 1000), 200, char_size[11], char_size[11]); 
  // ?=12
  fill(char_values[0],char_mapped_trans[12]);
  ellipse(map(12, 0, 14, 0, 1000), 200, char_size[12], char_size[12]); 
    // 1
  fill(num_values[0],num_mapped_trans[0]);
  ellipse(map(1, 0, 13, 0, 1000), 50, num_size[0], num_size[0]);  
  // 2
  fill(num_values[1],num_mapped_trans[1]);
  ellipse(map(2, 0, 13, 0, 1000), 50, num_size[1], num_size[1]);  
  // 3
  fill(num_values[2],num_mapped_trans[2]);
  ellipse(map(3, 0, 13, 0, 1000), 50, num_size[2], num_size[2]);  
  // 4
  fill(num_values[3],num_mapped_trans[3]);
  ellipse(map(4, 0, 13, 0, 1000), 50, num_size[3], num_size[3]); 
  // 5
  fill(num_values[4],num_mapped_trans[4]);
  ellipse(map(5, 0, 13, 0, 1000), 50, num_size[4], num_size[4]); 
  // 6
  fill(num_values[5],num_mapped_trans[5]);
  ellipse(map(6, 0, 13, 0, 1000), 50, num_size[5], num_size[5]); 
  // 7
  fill(num_values[6],num_mapped_trans[6]);
  ellipse(map(7, 0, 13, 0, 1000), 50, num_size[6], num_size[6]); 
  // 8
  fill(num_values[7],num_mapped_trans[7]);
  ellipse(map(8, 0, 13, 0, 1000), 50, num_size[7], num_size[7]); 
  // 9
  fill(num_values[8],num_mapped_trans[8]);
  ellipse(map(9, 0, 13, 0, 1000), 50, num_size[8], num_size[8]); 
  // 0
  fill(num_values[9],num_mapped_trans[9]);
  ellipse(map(10, 0, 13, 0, 1000), 50, num_size[9], num_size[9]); 

  mousetransparency += dtrans;
if (space_trans > 0.1){
  space_trans += dtrans;
}  
  for (int i =0; i<26; i++){
    if (letter_transparency[i] > 0.1){
      letter_transparency[i] += dtrans;
    }
  }
  for (int i =0; i<13; i++){
    if (char_transparency[i] > 0.1){
      char_transparency[i] += dtrans;
    }
  }
  for (int i =0; i<10; i++){
    if (num_trans[i] > 0.1){
      num_trans[i] += dtrans;
    }
  }
  
  if (key_speed > - 134) {
    key_speed -= 0.1;
  }
}


void mousePressed() {
  x = mouseX;
  y = mouseY;
  mousetransparency = 1;
  if (mouseButton == LEFT) {
    mouse_value = color(#e8d3ba);
  }
  else {
    mouse_value = color(#F1B0D0);     
  }
}

void keyPressed() {
  if (total_text.length() > 180){
    total_text= ""; // to clear the box
  }
  
  // increment key speed for every key pressed
  if (key_speed < 50)
  {
    key_speed += 0.7 ;
  }
  
  // backspace
  if (key == BACKSPACE) 
  {
    if (total_text.length() > 0){
      total_text = total_text.substring(0, total_text.length() -1);      
    }
  }
  
  if (key == ' ') 
  {
      total_text += key;
    space_value = #87c9b8;
    space_trans = 1;
  }

  if (key == 'a' || key == 'A'){
      total_text += key;
      letter_pressed[0] +=1;
    if (key == 'A') {
      letter_values[0] = #d91633;
    }
    else{
      letter_values[0] = #a98ec9;
    }
    letter_transparency[0] = 1;
  }
  if (key == 'b' || key == 'B'){
      total_text += key;
      letter_pressed[1] +=1;
    if (key == 'B') {
      letter_values[1] = #d91633;
    }
    else{
      letter_values[1] = #a98ec9;
    }
    letter_transparency[1] = 1;
  }
  if (key == 'c' || key == 'C'){
      total_text += key;
      letter_pressed[2] +=1;
    if (key == 'C') {
      letter_values[2] = #d91633;
    }
    else{
      letter_values[2] = #a98ec9;
    }
    letter_transparency[2] = 1;
  }
  if (key == 'd' || key == 'D'){
      letter_pressed[3] +=1;
      total_text += key;
    if (key == 'D') {
      letter_values[3] = #d91633;
    }
    else{
      letter_values[3] = #a98ec9;
    }
    letter_transparency[3] = 1;
  }
  if (key == 'e' || key == 'E'){
      total_text += key;
      letter_pressed[4] +=1;
    if (key == 'E') {
      letter_values[4] = #d91633;
    }
    else{
      letter_values[4] = #a98ec9;
    }
    letter_transparency[4] = 1;
  }
  if (key == 'f' || key == 'F'){
      total_text += key;
      letter_pressed[5] +=1;
    if (key == 'F') {
      letter_values[5] = #d91633;
    }
    else{
      letter_values[5] = #a98ec9;
    }
    letter_transparency[5] = 1;
  }
  if (key == 'g' || key == 'G'){
      total_text += key;
      letter_pressed[6] +=1;
    if (key == 'G') {
      letter_values[6] = #d91633;
    }
    else{
      letter_values[6] = #a98ec9;
    }
    letter_transparency[6] = 1;
  }
  if (key == 'h' || key == 'H'){
    letter_pressed[7] +=1;
      total_text += key;
    if (key == 'H') {
      letter_values[7] = #d91633;
    }
    else{
      letter_values[7] = #a98ec9;
    }
    letter_transparency[7] = 1;
  }
  if (key == 'i' || key == 'I'){
      total_text += key;
      letter_pressed[8] +=1;
    if (key == 'I') {
      letter_values[8] = #d91633;
    }
    else{
      letter_values[8] = #a98ec9;
    }
    letter_transparency[8] = 1;
  }
  if (key == 'J' || key == 'j'){
      total_text += key;
      letter_pressed[9] +=1;
      if (key == 'J') {
        letter_values[9] = #d91633;
    }
    else{
      letter_values[9] = #a98ec9;
    }
    letter_transparency[9] = 1;
  }
  if (key == 'K' || key == 'k'){
      total_text += key;
      letter_pressed[10] +=1;
    if (key == 'K') {
      letter_values[10] = #d91633;
    }
    else{
      letter_values[10] = #a98ec9;
    }
    letter_transparency[10] = 1;
  }
  if (key == 'l' || key == 'L'){
      total_text += key;
      letter_pressed[11] +=1;
    if (key == 'L') {
      letter_values[11] = #d91633;
    }
    else{
      letter_values[11] = #a98ec9;
    }
    letter_transparency[11] = 1;
  }
  if (key == 'M' || key == 'm'){
      total_text += key;
      letter_pressed[12] +=1;
    if (key == 'M') {
      letter_values[12] = #d91633;
    }
    else{
      letter_values[12] = #a98ec9;
    }
    letter_transparency[12] = 1;
  }
  if (key == 'n' || key == 'N'){
      total_text += key;
      letter_pressed[13] +=1;
    if (key == 'N') {
      letter_values[13] = #d91633;
    }
    else{
      letter_values[13] = #a98ec9;
    }
    letter_transparency[13] = 1;
  }
  if (key == 'O' || key == 'o'){
      total_text += key;
      letter_pressed[14] +=1;
    if (key == 'O') {
      letter_values[14] = #d91633;
    }
    else{
      letter_values[14] = #a98ec9;
    }
    letter_transparency[14] = 1;
  }
  if (key == 'p' || key == 'P'){
      total_text += key;
      letter_pressed[15] +=1;
    if (key == 'P') {
      letter_values[15] = #d91633;
    }
    else{
      letter_values[15] = #a98ec9;
    }
    letter_transparency[15] = 1;
  }
  if (key == 'Q' || key == 'q'){
      total_text += key;
      letter_pressed[16] +=1;
    if (key == 'Q') {
      letter_values[16] = #d91633;
    }
    else{
      letter_values[16] = #a98ec9;
    }
    letter_transparency[16] = 1;
  }
  if (key == 'R' || key == 'r'){
      total_text += key;
      letter_pressed[17] +=1;
    if (key == 'R') {
      letter_values[17] = #d91633;
    }
    else{
      letter_values[17] = #a98ec9;
    }
    letter_transparency[17] = 1;
  }
  if (key == 'S' || key == 's'){
      total_text += key;
      letter_pressed[18] +=1;
    if (key == 'S') {
      letter_values[18] = #d91633;
    }
    else{
      letter_values[18] = #a98ec9;
    }
    letter_transparency[18] = 1;
  }
  if (key == 'T' || key == 't'){
      total_text += key;
      letter_pressed[19] +=1;
    if (key == 'T') {
      letter_values[19] = #d91633;
    }
    else{
      letter_values[19] = #a98ec9;
    }
    letter_transparency[19] = 1;
  }
  if (key == 'U' || key == 'u'){
      total_text += key;
      letter_pressed[20] +=1;
    if (key == 'U') {
      letter_values[20] = #d91633;
    }
    else{
      letter_values[20] = #a98ec9;
    }
    letter_transparency[20] = 1;
  }
  if (key == 'V' || key == 'v'){
      total_text += key;
      letter_pressed[21] +=1;
    if (key == 'V') {
      letter_values[21] = #d91633;
    }
    else{
      letter_values[21] = #a98ec9;
    }
    letter_transparency[21] = 1;
  }
  if (key == 'w' || key == 'W'){
      total_text += key;
      letter_pressed[22] +=1;
    if (key == 'W') {
      letter_values[22] = #d91633;
    }
    else{
      letter_values[22] = #a98ec9;
    }
    letter_transparency[22] = 1;
  }
  if (key == 'x' || key == 'X'){
      total_text += key;
      letter_pressed[23] +=1;
    if (key == 'X') {
      letter_values[23] = #d91633;
    }
    else{
      letter_values[23] = #a98ec9;
    }
    letter_transparency[23] = 1;
  }
  if (key == 'y' || key == 'Y'){
      total_text += key;
      letter_pressed[24] +=1;
    if (key == 'Y') {
      letter_values[24] = #d91633;
    }
    else{
      letter_values[24] = #a98ec9;
    }
    letter_transparency[24] = 1;
  }
  if (key == 'Z' || key == 'z'){
      total_text += key;
      letter_pressed[25] +=1;
    if (key == 'Z') {
      letter_values[25] = #d91633;
    }
    else{
      letter_values[25] = #a98ec9;
    }
    letter_transparency[25] = 1;
  }
  if (key == '!'){
      total_text += key;
      char_pressed[0] +=1;
      char_values[0] = #e3dd2d;
      char_transparency[0] = 1;
  }
  if (key == '@'){
      total_text += key;
      char_pressed[1] +=1;
      char_values[1] = #e3dd2d;
      char_transparency[1] = 1;
  }
  if (key == '#'){
      total_text += key;
      char_pressed[2] +=1;
      char_values[2] = #e3dd2d;
      char_transparency[2] = 1;
  }
    if (key == '$'){
      total_text += key;
      char_pressed[3] +=1;
      char_values[3] = #e3dd2d;
      char_transparency[3] = 1;
  }
    if (key == '%'){
      total_text += key;
      char_pressed[4] +=1;
      char_values[4] = #e3dd2d;
      char_transparency[4] = 1;
  }
    if (key == '^'){
      total_text += key;
      char_pressed[5] +=1;
      char_values[5] = #e3dd2d;
      char_transparency[5] = 1;
  }
    if (key == '&'){
      total_text += key;
      char_pressed[6] +=1;
      char_values[6] = #e3dd2d;
      char_transparency[6] = 1;
  }
    if (key == '*'){
      total_text += key;
      char_pressed[7] +=1;
      char_values[7] = #e3dd2d;
      char_transparency[0] = 1;
  }
    if (key == '('){
      total_text += key;
      char_pressed[8] +=1;
      char_values[8] = #e3dd2d;
      char_transparency[8] = 1;
  }
    if (key == ')'){
      total_text += key;
      char_pressed[9] +=1;
      char_values[9] = #e3dd2d;
      char_transparency[9] = 1;
  }
    if (key == ','){
      total_text += key;
      char_pressed[10] +=1;
      char_values[10] = #e3dd2d;
      char_transparency[10] = 1;
  }
    if (key == '.'){
      total_text += key;
      char_pressed[11] +=1;
      char_values[11] = #e3dd2d;
      char_transparency[11] = 1;
  }
    if (key == '?'){
      total_text += key;
      char_pressed[12] +=1;
      char_values[12] = #e3dd2d;
      char_transparency[12] = 1;
  }
      if (key == '1'){
        total_text += key;
        num_pressed[0] +=1;
        num_values[0] = #c0e0ad;
        num_trans[0] = 1;
  }
      if (key == '2'){
        total_text += key;
        num_pressed[1] +=1;
        num_values[1] = #c0e0ad;
        num_trans[1] = 1;
  }
      if (key == '3'){
        total_text += key;
        num_pressed[2] +=1;
        num_values[2] = #c0e0ad;
        num_trans[2] = 1;
  }
      if (key == '4'){
        total_text += key;
        num_pressed[3] +=1;
        num_values[3] = #c0e0ad;
        num_trans[3] = 1;
  }
      if (key == '5'){
        num_pressed[4] +=1;
        total_text += key;
        num_values[4] = #c0e0ad;
        num_trans[4] = 1;
  }
      if (key == '6'){
        num_pressed[5] +=1;
        total_text += key;
        num_values[5] = #c0e0ad;
        num_trans[5] = 1;
  }
      if (key == '7'){
        num_pressed[6] +=1;
        total_text += key;
        num_values[6] = #c0e0ad;
        num_trans[6] = 1;
  }
      if (key == '8'){
        num_pressed[7] +=1;
        total_text += key;
        num_values[7] = #c0e0ad;
        num_trans[7] = 1;
  }
      if (key == '9'){
        num_pressed[8] +=1;
        total_text += key;
        num_values[8] = #c0e0ad;
        num_trans[8] = 1;
  }
      if (key == '0'){
        num_pressed[9] +=1;
        total_text += key;
        num_values[9] = #c0e0ad;
        num_trans[9] = 1;
  }
  
}
