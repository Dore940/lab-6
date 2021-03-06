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
