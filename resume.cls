%%
%% ============================================================================
%% resume.cls
%% Modern Professional Resume Class
%% Version : 1.1 (corrected)
%% Engine  : XeLaTeX or LuaLaTeX
%% ============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/07/16 Professional Resume Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Class Options
%% \IfFontExistsTF is unreliable for auto-detecting Lato: on systems using
%% fontconfig, a missing font often gets fuzzy-matched to a substitute and
%% is reported as "existing" anyway, which breaks silently at load time.
%% So font choice is an explicit opt-in option instead of auto-detected.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifcv@uselato
\cv@uselatofalse
\DeclareOption{lato}{\cv@uselatotrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% Base Class
\LoadClass[10pt,a4paper]{article}

%% Required Engine
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\newif\ifmodernengine

\ifxetex
    \modernenginetrue
\else
    \ifluatex
        \modernenginetrue
    \else
        \modernenginefalse
    \fi
\fi

\ifmodernengine\else
    \ClassError{resume}
    {This class requires XeLaTeX or LuaLaTeX}
    {Compile using XeLaTeX or LuaLaTeX.}
\fi

%% Packages
\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{tabularx}
\RequirePackage{enumitem}
\RequirePackage{paracol}
\RequirePackage{fontawesome5}
\RequirePackage{setspace}
\RequirePackage{ragged2e}
\RequirePackage{hyperref} % loaded last among these so it can pick up PDF metadata cleanly

%% Geometry
\geometry{
  paper=a4paper,
  top=1.30cm,
  bottom=1.35cm,
  left=1.40cm,
  right=1.40cm,
  headheight=0pt,
  headsep=0pt,
  footskip=0pt
}

\pagestyle{empty}

%% Fonts
\defaultfontfeatures{Ligatures=TeX, Scale=MatchLowercase}

% Default: TeX Gyre Heros, a Helvetica-metric-compatible font that ships
% with every standard TeX Live / MiKTeX install, so the class always
% compiles out of the box. Pass the "lato" class option
% (\documentclass[lato]{resume}) if Lato is installed on your system.
\ifcv@uselato
  \IfFontExistsTF{Lato}
    {
      \setmainfont[
        UprightFont=* Regular,
        BoldFont=* Bold,
        ItalicFont=* Italic,
        BoldItalicFont=* Bold Italic
      ]{Lato}
    }
    {
      \ClassWarning{resume}{Lato not found on this system; falling back to TeX Gyre Heros}
      \setmainfont{TeX Gyre Heros}
    }
\else
  \setmainfont{TeX Gyre Heros}
\fi

\newcommand{\NameFont}{\fontsize{28}{31}\selectfont\bfseries}
\newcommand{\TitleFont}{\fontsize{13}{15}\selectfont}
\newcommand{\SectionFont}{\fontsize{15}{17}\selectfont\bfseries}
\newcommand{\CompanyFont}{\fontsize{11}{13}\selectfont\bfseries}
\newcommand{\BodyFont}{\fontsize{9.4}{12}\selectfont}
\newcommand{\SmallFont}{\fontsize{8.4}{10.5}\selectfont}

%% Colors
%% NOTE: these must be defined *before* \hypersetup, which references them.
\definecolor{ResumeBlue}{HTML}{2E74B5}
\definecolor{ResumeBlack}{HTML}{222222}
\definecolor{ResumeGray}{HTML}{666666}
\definecolor{ResumeLightGray}{HTML}{A5A5A5}
\definecolor{ResumeRule}{HTML}{1D1D1D}

%% Hyperlinks (colors above are now defined, so this no longer errors)
\hypersetup{
  colorlinks=true,
  urlcolor=ResumeBlue,
  linkcolor=ResumeBlue,
  citecolor=ResumeBlue,
  pdfcreator={XeLaTeX},
  pdfproducer={XeLaTeX}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Global Typography
%% \color and \setstretch are deferred to \AtBeginDocument so they act on the
%% actual document body rather than being evaluated mid-preamble.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
  \color{ResumeBlack}
  \setstretch{1.10}
}

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.20em}

%% Column Widths
\newlength{\LeftColumnWidth}
\newlength{\RightColumnWidth}
\newlength{\ColumnGap}

\setlength{\LeftColumnWidth}{0.63\textwidth}
\setlength{\RightColumnWidth}{0.33\textwidth}
\setlength{\ColumnGap}{0.04\textwidth}

%% Itemize
\setlist[itemize]{
  label=\textbullet,
  leftmargin=*,
  itemsep=1.5pt,
  topsep=1.5pt,
  parsep=0pt,
  partopsep=0pt
}

\renewcommand{\arraystretch}{1.15}
\graphicspath{{images/}}
\emergencystretch=3em
\sloppy

%% Section / Header Measurements
\newlength{\HeaderSpace}
\newlength{\SectionSpace}
\newlength{\RuleSpace}
\setlength{\HeaderSpace}{1.1cm}
\setlength{\SectionSpace}{0.35cm}
\setlength{\RuleSpace}{0.15cm}

\newcommand{\HeaderRule}{%
  \vspace{0.2cm}
  {\color{ResumeRule}\rule{\linewidth}{0.5pt}}%
  \vspace{0.25cm}%
}

\newcommand{\SectionRule}{%
  \vspace{0.12cm}
  {\color{ResumeRule}\rule{\linewidth}{0.4pt}}%
  \vspace{0.25cm}%
}

\newcommand{\cvsection}[1]{%
  \vspace{\SectionSpace}%
  \noindent{\SectionFont\MakeUppercase{#1}\par}%
  \SectionRule
}

\newcommand{\sidebarsection}[1]{%
  \vspace{0.45cm}%
  \noindent{\fontsize{12}{13}\selectfont\bfseries\MakeUppercase{#1}\par}%
  \vspace{2mm}%
  {\color{ResumeRule}\rule{\linewidth}{0.35pt}}%
  \vspace{0.25cm}%
}

\newcommand{\name}[1]{{\NameFont #1\par}}

\newcommand{\profession}[1]{%
  \vspace{2mm}%
  {\TitleFont\color{ResumeBlue}#1\par}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Contact Line
%% #1 phone  #2 email  #3 linkedin (no protocol)  #4 location
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\contactinfo}[4]{%
  \vspace{0.15cm}
  \noindent{\SmallFont
    \faPhone\space#1%
    \space\space\textbullet\space\space
    \faEnvelope\space\href{mailto:#2}{#2}%
    \space\space\textbullet\space\space
    \faLinkedin\space\href{https://#3}{#3}%
    \space\space\textbullet\space\space
    \faMapMarker*\space#4%
  \par}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Resume Header
%% #1 Name  #2 Profession/title  #3 Phone  #4 Email  #5 LinkedIn  #6 Location
%% (Previously this took 4 args but only forwarded 1 to \contactinfo, which
%%  needs 4 -- that mismatch is fixed here by taking all 6 pieces directly.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\makecvheader}[6]{%
  \name{#1}%
  \profession{#2}%
  \contactinfo{#3}{#4}{#5}{#6}%
  \HeaderRule
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Two Column Layout
%% \begin{cvcolumns} \cvleftcolumn ... \cvrightcolumn ... \end{cvcolumns}
%% (Previously \leftcolumn/\rightcolumn existed with no environment ever
%%  opening/closing paracol, which errored with "Not in paracol environment".
%%  They are also deliberately NOT named \leftcolumn/\rightcolumn/\switchcolumn,
%%  because paracol reserves those exact names for its own internal shorthand
%%  and silently overrides them inside its environment.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\columnratio{0.63}
\setlength{\columnsep}{0.9cm}

\newenvironment{cvcolumns}
  {\begin{paracol}{2}}
  {\end{paracol}}

% NOTE: paracol reserves the exact names \leftcolumn, \rightcolumn, and
% \switchcolumn for its own internal (and mutually incompatible) shorthand
% commands -- it silently overrides them inside \begin{paracol}, so this
% class deliberately uses differently-named wrappers to avoid the collision.
\newcommand{\cvleftcolumn}{}% no-op: paracol starts in the left column automatically
\newcommand{\cvrightcolumn}{\switchcolumn}% moves to the right column

%% Sidebar Text
\newcommand{\sideitem}[1]{{\BodyFont #1\par}\vspace{0.1cm}}
\newenvironment{sidebarlist}{\begin{flushleft}\BodyFont}{\end{flushleft}}
\newenvironment{achievement}{\begin{flushleft}\BodyFont}{\end{flushleft}}

\newcommand{\divider}{%
  \vspace{0.2cm}
  {\color{ResumeLightGray}\rule{\linewidth}{0.25pt}}%
  \vspace{0.2cm}%
}

\newcommand{\smallspace}{\vspace{0.2cm}}
\newcommand{\mediumspace}{\vspace{0.25cm}}
\newcommand{\largespace}{\vspace{0.3cm}}

%% Experience / Education / Projects / Skills
\newlength{\EntrySpace}
\setlength{\EntrySpace}{0.15cm}

\newcommand{\entrydate}[1]{\hfill{\SmallFont\color{ResumeGray}#1}}
\newcommand{\entrylocation}[1]{{\SmallFont\color{ResumeGray}\faMapMarker*~#1}}
\newcommand{\company}[1]{{\CompanyFont\color{ResumeBlue}#1}}
\newcommand{\jobtitle}[1]{{\fontsize{13}{15}\selectfont\bfseries\color{ResumeBlack}#1}}
\newcommand{\degree}[1]{{\fontsize{12}{14}\selectfont\bfseries#1}}
\newcommand{\projecttitle}[1]{{\fontsize{12}{14}\selectfont\bfseries#1}}
\newenvironment{resumelist}{\begin{itemize}}{\end{itemize}}
\newenvironment{experience}{\vspace{\EntrySpace}}{\vspace{0.15cm}}

% #1 Job Title  #2 Company  #3 Date  #4 Location  #5 Bullet items
\newcommand{\experienceentry}[5]{%
  \begin{experience}
    \jobtitle{#1}\entrydate{#3}\par
    \vspace{2pt}
    \company{#2}\hfill\entrylocation{#4}\par
    \vspace{0.35cm}
    #5
  \end{experience}%
}

% #1 Degree  #2 University  #3 Year  #4 Location
\newcommand{\educationentry}[4]{%
  \vspace{0.05cm}
  \degree{#1}\entrydate{#3}\par
  \vspace{1pt}
  \company{#2}\hfill\entrylocation{#4}\par
}

% #1 Project  #2 Organization  #3 Date  #4 Description
\newcommand{\projectentry}[4]{%
  \vspace{0.25cm}
  \projecttitle{#1}\entrydate{#3}\par
  \vspace{0.1pt}
  \company{#2}\par
  \vspace{0.1pt}
  {\BodyFont #4\par}%
}

\newcommand{\skill}[1]{{\BodyFont #1\par}\vspace{2pt}}
\newcommand{\cvlanguage}[2]{{\BodyFont\textbf{#1}\hfill{\SmallFont #2}\par}\vspace{2pt}}
\newcommand{\interest}[1]{{\BodyFont #1\par}\vspace{2pt}}
\newcommand{\achievementitem}[2]{%
  {\BodyFont\textbf{#1}\par}%
  \vspace{2pt}
  {\SmallFont #2\par}%
  \vspace{0.25cm}%
}

% #1 Title  #2 Authors  #3 Venue  #4 Date
\newcommand{\publication}[4]{%
  {\BodyFont\textbf{#1}\par}%
  \vspace{2pt}
  {\SmallFont #2\par}%
  \vspace{2pt}
  {\SmallFont #3\par}%
  \vspace{2pt}
  {\SmallFont #4\par}%
  \vspace{0.15cm}%
}

\newenvironment{sidebarblock}{\begin{flushleft}\BodyFont}{\end{flushleft}}

\newcommand{\bottomfill}{\vfill}
\newcommand{\resumeend}{\bottomfill}

