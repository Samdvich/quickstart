" --- WORKFLOW ---

set softtabstop=4 "Tab indentation
filetype indent plugin on "Attempt to figure out indentations (^^)
set autoindent "Stays on the same indentation

" --- VISUAL ELEMENTS ---

:set number "Line numbers
:syntax on "Syntax highlighting

" --- CONTROL ---

:set mouse=a "Touchpad Scroll
:set tsl=3 "Scroll Sensitivity

" --- FUNCTIONS ---

set wildmenu "Command-line completion [tab]

set hlsearch "Highlight the searched characters, rid with :noh
set ignorecase "Not case sensitive...
set smartcase " ...Unless there is an uppercase in the search query

set nostartofline "Doesn't default to the start of the line (not typical to vi)
set confirm "Modern interactivity instead of an error

" --- COLOR SCHEMES ---

":colorscheme peachpuff

:colorscheme industry
:highlight Normal ctermbg=black "Black background + dark compatible colours
