%% summary.cls -- jinka summary class
%% $B$=$l$C$]$$?M2J3X0LO@J8MWLs869F%/%i%9(B
%% $Revision: 25 $
%% $Date: 2008-01-22 02:45:12 +0900 (火, 22  1月 2008) $
%% Copyright (C) 2002  MIYAMOTO Yusuke

% $BF|K\8l(B pLaTeX $B$N(B jarticle $B$K4p$E$/!%(B
\LoadClass[11pt,a4j]{jarticle}

%% 45$B;z(B/$B9T(B
%% 40$B9T(B/$BJG(B
\setlength{\textwidth} {45\Chs}
\setlength{\textheight}{40\Cvs}

%% $BK\J8$r%;%s%?%j%s%0(B
%% ($B:81&(B/$B>e2<$N%^!<%8%s$O(B 25mm)
\setlength{\oddsidemargin}  {\paperwidth}
\addtolength{\oddsidemargin}{-\textwidth}
\setlength{\oddsidemargin}  {0.5\oddsidemargin}
\addtolength{\oddsidemargin}{-1in}
\setlength{\evensidemargin} {\oddsidemargin}


%% $B%?%$%H%k$N@_Dj(B
% $BI{Bj(B
\providecommand{\subtitle}[1]{\global\edef\@subtitle{#1}}

% $B%?%$%H%k$NAHHG(B
\renewcommand{\maketitle}{\par
  \begingroup
  \if@twocolumn
    \ifnum\col@number=\@ne \maketitle
    \else \twocolumn[\@maketitle]
    \fi
  \else
    \newpage
    \global\@topnum\z@
    \@maketitle
  \fi
  \thispagestyle{empty}
  \endgroup
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\p@thanks\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\@subtitle\@empty
  \global\let\title\relax
  \global\let\subtitle\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

\renewcommand{\@maketitle}{
  \newpage\null
  \begin{center}
    {\fontsize{14}{16}\selectfont\@title\par}  % 14pt
    \@ifundefined{@subtitle}
      {\relax}
      {\fontsize{12}{14}\selectfont\@subtitle} % 12pt
  \end{center}
  \begin{flushright}
    {\fontsize{12}{14}\@author}                % 12pt
  \end{flushright}
}

\endinput

