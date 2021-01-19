% SGH_thesis
% Written by Simon Hulse (simon.hulse@chem.ox.ac.uk), 2021

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SGH_thesis}[2021/01/14 Custom thesis class by Simon Hulse]

\LoadClass[openright,twoside,12pt,a4paper]{report}

\newif\ifelectronicversion
\electronicversiontrue

\DeclareOption{bindversion}{\electronicversionfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%%% colours
\RequirePackage{xcolor}
\definecolor{deepred}{HTML}{8b0000}


%%% font configuration
\RequirePackage{fontspec}
\RequirePackage[math-style=ISO,bold-style=ISO]{unicode-math}

% primary font: EB Garamond
\setmainfont{EBGaramond}[
Path           = fonts/,%
Extension      = .otf,%
UprightFont    = *-Regular,%
BoldFont       = *-Bold,%
ItalicFont     = *-Italic,%
BoldItalicFont = *-BoldItalic,%
]

% Maths font: Garamond Maths
\setmathfont{Garamond-Math}[
Extension    = .otf,%
Path         = fonts/,%
StylisticSet = {1,8,5},%
]

% Monospaced font: cmuntt (primarily as it supports unicode characters)
\setmonofont{cmuntt}[
Extension = .otf,%
Scale     = MatchLowercase,%
Path      = fonts/,%
]

\RequirePackage{eso-pic}
\RequirePackage{graphicx}

\linespread{1.25}

% college name
\def\college#1{\gdef\@college{#1}}
% degree name
\def\degree#1{\gdef\@degree{#1}}
% year and term
\def\degreedate#1{\gdef\@degreedate{#1}}

\def\supervisors#1{\gdef\@supervisors{#1}}
\newif\ifsupervisors

\def\crest{{\includegraphics[width=\textwidth]{figures/beltcrest_grey.pdf}}}


\ifelectronicversion
  \RequirePackage[%
  includehead,%
  top      = 3.5cm,%
  bottom   = 3.5cm,%
  inner    = 2.8cm,%
  outer    = 2.8cm,%
  headsep  = 0.8cm,%
  footskip = 1.5cm,%
  ]{geometry}
\else
  \RequirePackage[%
  includehead,%
  top      = 3.5cm,%
  bottom   = 3.5cm,%
  inner    = 3.8cm,%
  outer    = 1.8cm,%
  headsep  = 0.8cm,%
  footskip = 1.5cm,%
  ]{geometry}
\fi

%%% Headers
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}
\fancyhf{}

\fancyhead[LE]{%
  \makebox[0pt][r]{%
    \colorbox{deepred}{\makebox[\textwidth][r]{\textcolor{white}{\thepage}\enskip}}\hspace*{1em}}%
  {\rightmark}\hspace*{1em}\headrulefill%
}
\fancyhead[RO]{%
  \mbox{}\headrulefill \hspace*{1em}{\leftmark}%
  \makebox[0pt][l]{%
    \hspace*{1em}\colorbox{deepred}{\makebox[\textwidth][l]{\enskip\textcolor{white}{\thepage}}}}%
}
\renewcommand\headrulewidth{0pt}

\fancypagestyle{plain}{\fancyhf{}}
%   \fancyhead[LE]{%
%     \makebox[0pt][r]{
%       \colorbox{deepred}{\makebox[\textwidth][r]{\textcolor{white}{\thepage}\enskip}}\hspace*{1em}}%
%     {\rightmark}\hspace*{1em}\headrulefill%
%   }
%   \fancyhead[RO]{%
%     \mbox{}\headrulefill \hspace*{1em}{\leftmark}%
%     \makebox[0pt][l]{%
%       \hspace*{1em}\colorbox{deepred}{\makebox[\textwidth][l]{\enskip\textcolor{white}{\thepage}}}}%
%   }
% }

\def\headrulefill{\leaders\hrule width 0pt height 3pt depth -2.8pt \hfill}

% clear empty trailing left page
% http://www.texfaq.org/FAQ-reallyblank
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\origdoublepage}%
}
\let\cleardoublepage\clearemptydoublepage

%%% ToC formatting
\RequirePackage{titletoc}
% % \tocless will be used to make summary not present in ToC
% \newcommand{\nocontentsline}[3]{}
% \newcommand{\tocless}[2]{\bgroup\let\addcontentsline=\nocontentsline#1{#2}\egroup}

\titlecontents{chapter}[0pt]{\vspace{15pt}\bfseries\large\color{deepred}}{\contentslabel{0pt}\scshape\hspace{20pt}}{}{\hfill\upshape\contentspage}[]
\titlecontents{section}[20pt]{\vspace{5pt}\bfseries}{\contentslabel{0pt}\hspace{30pt}}{}{\mdseries\titlerule*[.5pc]{.}\bfseries\contentspage}
\titlecontents{subsection}[40pt]{}{\contentslabel{0pt}\hspace{35pt}}{\contentsmargin{0pt}\scshape}{\titlerule*[.5pc]{.}\contentspage}[]
\titlecontents{subsubsection}[60pt]{}{}{\contentsmargin{0pt}\itshape}{\titlerule*[.5pc]{.}\contentspage}[]

%%% Chapter and Section titles
\RequirePackage[explicit]{titlesec}
\RequirePackage{anyfontsize}

\titleformat{\chapter}[display]
  {\Huge}
  {\scshape\flushright{\fontsize{72}{0}\textcolor{deepred}{\thechapter}}}{0pt}
  {#1\vskip60pt}
% \titleformat{\chapter}{\flushright\scshape\fontsize{72}{60}\bfseries}{\thechapter}{20pt}{\Huge}
% \titleformat{\chapter}{\bfseries}{\scshape\fontsize{72}{60}\color{deepred}}{\hfill}{}[]


\renewcommand*{\maketitle}{%
\begin{titlepage}
  \AddToShipoutPictureBG*{%
  	\AtTextCenter{\makebox(0,0){\includegraphics[width=\textwidth]{figures/beltcrest_grey.pdf}}%
  }}
	\begin{center}
  	\begin{minipage}[t][15cm][b]{\textwidth}
    	\begin{center}
        \huge
        \@title\\[1cm]
      	\scshape\LARGE
      	\@author\\[0.5cm]
      	\large\mdseries\upshape
      	\@college\\
      	University of Oxford\\[1cm]
        A thesis submitted for the degree of\\
        \itshape
        \@degree\\
        \upshape
        \@degreedate\\[1cm]
        \ifsupervisors
      	  Supervisors:\\
          \itshape
          \@supervisors
        \fi
    	\end{center}
  	\end{minipage}
	\end{center}
\end{titlepage}
}
