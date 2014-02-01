# Dom

This is an example of a simple shell script I wrote as a text-based interface for the scripts our support team had to use when configuring domain names for our user's websites. The path to the scripts was long and the command was more complicated than what they were used to, so I decided to hide the complexity using a text-based menu system. There was also an option to use command line arguments and flags, which made things easier for me.

This demo version doesn't do anything other than call script in other directories which echo a string indicating that they have been executed.

## Usage

Menu version:

    $ ./dom.sh

Command line version:

	$ ./dom.sh [-c | -u] [-a | -o][-h]

    -c	Create a new zone
    -u	Update a new zone
    -a	Type is an agent zone
    -o	Type is an office zone
    -h	Print this help screen
