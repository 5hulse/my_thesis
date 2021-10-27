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
% supervisors
\def\supervisors#1{\gdef\@supervisors{#1}}
\newif\ifsupervisors

\def\crest{{\includegraphics[width=\textwidth]{figures/beltcrest_grey.pdf}}}


\ifelectronicversion
  \RequirePackage[%
  includehead,%
  top      = 2.5cm,%
  bottom   = 2.5cm,%
  inner    = 2.8cm,%
  outer    = 2.8cm,%
  headsep  = 0.8cm,%
  footskip = 1.5cm,%
  ]{geometry}
\else
  \RequirePackage[%
  includehead,%
  top      = 2.5cm,%
  bottom   = 2.5cm,%
  inner    = 3.8cm,%
  outer    = 1.8cm,%
  headsep  = 0.8cm,%
  footskip = 1.5cm,%
  ]{geometry}
\fi

%%% Headers
\RequirePackage{fancyhdr}

\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\bfseries#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\bfseries#1}}
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

\def\headrulefill{\leaders\hrule width 0pt height 3pt depth -2.8pt \hfill}

% remove page numbering from plain pages
% affects chapter title pages
\fancypagestyle{plain}{\fancyhf{}}

% clear empty trailing left page
% http://www.texfaq.org/FAQ-reallyblank
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\origdoublepage}%
}
\let\cleardoublepage\clearemptydoublepage

%%% Chapter and Section titles
\RequirePackage[explicit]{titlesec}
\RequirePackage{anyfontsize}

\newenvironment{numberlesschapter}
  {\setcounter{secnumdepth}{0}}
  {\setcounter{secnumdepth}{2}}

\titleformat{\chapter}[hang]{}{%
  \begin{minipage}[c][3em][c]{.8\textwidth}
    \bfseries\fontsize{40}{40}\selectfont#1
  \end{minipage}
  \hspace*{3em}
  \colorbox{deepred}{%
    \begin{minipage}[c][5em][c]{.5\textwidth}
      {\hspace*{.5em}\fontsize{90}{90}\selectfont\textcolor{white}{\scshape\thechapter}}
    \end{minipage}
}}{0pt}{}[\vspace*{5em}]

%%% ToC formatting
\RequirePackage{titletoc}
% % \tocless will be used to make summary not present in ToC
% \newcommand{\nocontentsline}[3]{}
% \newcommand{\tocless}[2]{\bgroup\let\addcontentsline=\nocontentsline#1{#2}\egroup}
\renewcommand*\contentsname{Contents}
\titlecontents{chapter}[0pt]{\vspace{15pt}\bfseries\large\color{deepred}}{\contentslabel{0pt}\scshape\hspace{20pt}}{}{\hfill\upshape\contentspage}[]
\titlecontents{section}[20pt]{\vspace{5pt}\bfseries}{\contentslabel{0pt}\hspace{30pt}}{}{\mdseries\titlerule*[.5pc]{.}\bfseries\contentspage}
\titlecontents{subsection}[40pt]{}{\contentslabel{0pt}\hspace{35pt}}{\contentsmargin{0pt}\scshape}{\titlerule*[.5pc]{.}\contentspage}[]
\titlecontents{subsubsection}[60pt]{}{}{\contentsmargin{0pt}\itshape}{\titlerule*[.5pc]{.}\contentspage}[]

\renewcommand{\contentsname}{Contents}
\renewcommand\tableofcontents{%
    \numberlesschapter{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    }

\renewcommand*{\maketitle}{%
\begin{titlepage}
  \AddToShipoutPictureBG*{%
  	\AtTextCenter{\makebox(0,0){\includegraphics[width=\textwidth]{figures/beltcrest_grey.pdf}}%
  }}
	\begin{center}
  	\begin{minipage}[t][16.5cm][b]{\textwidth}
    	\begin{center}
        \huge
        \@title\\[1cm]
      	\scshape\LARGE\bfseries\textcolor{deepred}{\@author}\\[0.5cm]
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

% % Chapter quotation environment
% \makeatletter
% \newenvironment{chapquote}[2][2em]
%   {\setlength{\@tempdima}{#1}%
%    \def\chapquote@author{#2}%
%    \parshape 1 \@tempdima \dimexpr\textwidth-2\@tempdima\relax%
%    \itshape}
%   {\par\normalfont\hfill--\ \chapquote@author\hspace*{\@tempdima}\par\bigskip}
% \makeatother

% This macro define an environment for front matter that is always
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi}%
       {\if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}

% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.

\newenvironment{dedication}
{\begin{alwayssingle}
 \thispagestyle{empty}
 \begin{center}
 \vspace*{1.5cm}
 {\LARGE }
 \end{center}
 \vspace{0.5cm}
 \begin{verse}\begin{center}}
{\end{center}\end{verse}\end{alwayssingle}}

% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

\newenvironment{acknowledgements}
{\chapter*{Acknowledgements}}{}
