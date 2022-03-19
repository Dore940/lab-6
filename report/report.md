---
# Front matter
title: "Отчёт по лабораторной работе №6"
subtitle: "Вариант 44"
author: "Василий Олегович Худицкий"

# Generic otions
lang: ru-RU
toc-title: "Содержание"

# Pdf output format
toc: true # Table of contents
toc_depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
### Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Misc options
indent: true
header-includes:
  - \linepenalty=10 # the penalty added to the badness of each line within a paragraph (no associated penalty node) Increasing the value makes tex try to have fewer lines in the paragraph.
  - \interlinepenalty=0 # value of the penalty (node) added after each line of a paragraph.
  - \hyphenpenalty=50 # the penalty for line breaking at an automatically inserted hyphen
  - \exhyphenpenalty=50 # the penalty for line breaking at an explicit hyphen
  - \binoppenalty=700 # the penalty for breaking a line at a binary operator
  - \relpenalty=500 # the penalty for breaking a line at a relation
  - \clubpenalty=150 # extra penalty for breaking after first line of a paragraph
  - \widowpenalty=150 # extra penalty for breaking before last line of a paragraph
  - \displaywidowpenalty=50 # extra penalty for breaking before last line before a display math
  - \brokenpenalty=100 # extra penalty for page breaking after a hyphenated line
  - \predisplaypenalty=10000 # penalty for breaking before a display
  - \postdisplaypenalty=0 # penalty for breaking after a display
  - \floatingpenalty = 20000 # penalty for splitting an insertion (can only be split footnote in standard LaTeX)
  - \raggedbottom # or \flushbottom
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

- Научиться строить простейшую модель эпидемии.
- Рассмотреть два случая протекания эпидемии.
- Научиться строить графики изменения числа особей в каждой из трех групп.


# Задание

На одном острове вспыхнула эпидемия. Известно, что из всех проживающих на острове ($N=5555$) в момент начала эпидемии ($t=0$) число заболевших людей (являющихся распространителями инфекции) $I(0)=75$. А число здоровых людей с иммунитетом к болезни $R(0)=4$. Таким образом, число людей восприимчивых к болезни, но пока здоровых, в начальный момент времени $S(0)=N-I(0)- R(0)$. Постройте графики изменения числа особей в каждой из трех групп. Рассмотрите, как будет протекать эпидемия в случае:

1) если $I(0) \leqslant I^*$
2) если $I(0) > I^*$

# Теоретическое введение

Рассмотрим простейшую модель эпидемии. Предположим, что некая популяция, состоящая из $N$ особей, (считаем, что популяция изолирована) подразделяется на три группы. Первая группа - это восприимчивые к болезни, но пока здоровые особи, обозначим их через $S(t)$. Вторая группа – это число инфицированных особей, которые также при этом являются распространителями инфекции, обозначим их $I(t)$. А третья группа, обозначающаяся через $R(t)$ – это здоровые особи с иммунитетом к болезни.

До того, как число заболевших не превышает критического значения $I^*$, считаем, что все больные изолированы и не заражают здоровых. Когда $I(0) > I^*$,
тогда инфицирование способны заражать восприимчивых к болезни особей.

Таким образом, скорость изменения числа S(t) меняется по следующему закону:
$$
\frac{dS}{dt} = \begin{cases} - \alpha S, если \ I(t)>I^* \\ 0, если \ I(t) \leq I^* \end{cases}
$$
Поскольку каждая восприимчивая к болезни особь, которая, в конце концов, заболевает, сама становится инфекционной, то скорость изменения числа инфекционных особей представляет разность за единицу времени между заразившимися и теми, кто уже болеет и лечится, т.е.:
$$
\frac{dI}{dt} = \begin{cases} \alpha S - \beta I, если \ I(t)>I^* \\  - \beta I, если \ I(t) \leq I^* \end{cases}
$$
А скорость изменения выздоравливающих особей (при этом приобретающих
иммунитет к болезни)

$$\frac{dR}{dt}=\beta I$$

Постоянные пропорциональности
$\alpha , \beta$, - это коэффициенты заболеваемости и выздоровления соответственно.

Для того, чтобы решения соответствующих уравнений определялось однозначно, необходимо задать начальные условия.Считаем, что на начало эпидемии в момент времени $t=0$ нет особей с иммунитетом к болезни $R(0)=0$, а число инфицированных и восприимчивых к болезни особей
$I(0)$ и $S(0)$ соответственно. Для анализа картины протекания эпидемии необходимо рассмотреть два случая: $I(0) \leq I^*$ и $I(0) > I^*$


# Выполнение лабораторной работы

## 1. Случай 1 (если $I(0) \leqslant I^*$)

Код на Modelica:
```Modelica
 model lab06case1
  constant Real b = 0.02; //коэффициент выздоровления
  constant Real N = 5555; //общее число проживающих на острове
  
  Real R; // здоровые, с иммунитетом
  Real I; // заболевшие
  Real S; // здоровые, в зоне риска
  
 initial equation
  R = 4; // здоровые с иммунитетом в момент начала эпидемии
  I = 75; // заболевшие в момент начала эпидемии
  S = N-I-R; //восприимчивые, но пока здоровые в момент начала эпидемии
 equation
 //Случай 1: I<=I*
  der(S) = 0;
  der(I) = -b*I;
  der(R) = b*I; 
 end lab06case1;

```
Графики изменения числа особей в каждой из трех групп(рис. [-@fig:001]):
![Рис.1 Графики изменения числа особей для случая 1](image/2.png){#fig:001}

График изменения I(рис. [-@fig:002]):
![Рис.2 График изменения I для случая 1](image/3.png){#fig:002}

Графики изменения R(рис. [-@fig:003]):
![Рис.3 Графики изменения R для случая 1](image/4.png){#fig:003}

## 2. Случай 2 (если $I(0) > I^*$)

Код на Modelica:
```Modelica
 model lab06case2
  constant Real a = 0.01; //коэффициент заболеваемости
  constant Real b = 0.02; //коэффициент выздоровления
  constant Real N = 5555; //общее число проживающих на острове
  
  Real R; // здоровые, с иммунитетом
  Real I; // заболевшие
  Real S; // здоровые, в зоне риска
  
 initial equation
  R = 4; // здоровые с иммунитетом в момент начала эпидемии
  I = 75; // заболевшие в момент начала эпидемии
  S = N-I-R; //восприимчивые, но пока здоровые в момент начала эпидемии
 equation
 //Случай 2: I>I*
  der(S)=-a*S "изменение числа восприимчивых к болезни, но пока здоровых";
  der(I)=a*S-b*I "изменение числа инфецированных распространителей";
  der(R)=b*I "изменение числа здоровых с иммунитетом";
 end lab06case2;
```
Графики изменения числа особей в каждой из трех групп(рис. [-@fig:004]):
![Рис.4 Графики изменения числа особей для случая 2](image/1.png){#fig:004}

# Выводы

Научился строить
- простейшую модель эпидемии, рассматривая два случая протекания эпидемии,
- графики изменения числа особей в каждой из трех групп для простейшей модели эпидемии.


# Список литературы

- <code>[Кулябов Д.С. *Лабораторная работа №6*](https://esystem.rudn.ru/mod/resource/view.php?id=831045)</code>
- <code>[Кулябов Д.С. *Задания к лабораторной работе №6 (по вариантам)*](https://esystem.rudn.ru/mod/resource/view.php?id=831050)</code>