# odin-connect-four

A ruby implementation of the [Connect Four game](https://en.wikipedia.org/wiki/Connect_Four), created as part of [The Odin Project](https://www.theodinproject.com/about).

### Game overview

Connect Four is a two-player connection game in which the players take turns dropping colored discs from the top into a grid. The objective of the game is to be the first to form a horizontal, vertical, or diagonal line of four of one's own discs.

### Features

- Comprehensive [Rspec](https://rspec.info/) based test suite
- Command-line interface
- Some attempts at ascii art

### Installation

1. Ensure Ruby is installed on your system.
2. Clone the repository:
   ```
   git clone git@github.com:Everesh/odin-connect-four.git
   ```
3. Navigate to the project directory:
   ```
   cd odin-connect-four
   ```
4. Run the game
   ```
   ruby lib/play.rb
   ```
Bonus: Run the tests
1. Install Rspec
   ```
   bundle install
   ```
2. Run Rspec
   ```
   rspec

   #Or the verbose version
   rspec -f d
   ```
