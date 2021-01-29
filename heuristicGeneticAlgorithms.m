clc;
clear all;
%in this script we are going to code genetic algorithm
global demand irr tamb wind
a=1;

demand = xlsread('demand.xlsx');
irr=xlsread('irradiation.xlsx'); %solar irradiance %W/m^2
tamb=xlsread('ambient.xlsx');
wind=xlsread('windspeed.xlsx');
iteration=0;
alpha=1.5;
child1=[0 0];
child2=[0 0];
bestConst1=0;
% generation1 = objection(newParent1);
% generation2 = objection(newParent2);

newParent1=[0 0];
newParent2=[0 0];
for i=0:1000
%modelling generation to chromosome
iteration=iteration+1;


[const1parent1,const2parent1]=constrains(newParent1);
totalConst1Parent1=abs(const1parent1)+abs(const2parent1);
[const1parent2,const2parent2]=constrains(newParent2);
totalConst1Parent2=abs(const1parent2)+abs(const2parent2);

%cross-over & mtation
    %we are going to use increasing or decreasing the genom
        %determine minus or plus rand(1)
        %child wil get 45  percentfrom parent1 and 45percent from parent2 
        % 10 percent mutation
%for first child
number=rand(1);
if number*100>90
    if rand(1)>0.5
    child1=[child1(1)+alpha child1(2)];
    else
    child1=[child1(1)-alpha child1(2)];
    end
    if rand(1)>0.5
    child1=[child1(1) child1(2)+alpha];
    else
    child1=[child1(1) child1(2)-alpha];
    end
elseif number*100<90 && number*100>45
    child1=[newParent1(1) newParent2(2)];
elseif number*100>0 && number*100<45
    child1=[newParent2(1) newParent1(2)];
end

number=rand(1);
if number*100>90
    if rand(1)>0.5
    child2=[child2(1)+alpha child2(2)];
    else
    child2=[child2(1)-alpha child2(2)];
    end
    if rand(1)>0.5
    child2=[child2(1) child2(2)+alpha];
    else
    child2=[child2(1) child2(2)-alpha];
    end
elseif number*100<90 && number*100>45
    child2=[newParent1(1) newParent2(2)];
elseif number*100>0 && number*100<45
    child2=[newParent2(1) newParent1(2)];
end

%new generation
% child1
% child2


%evaluation and kill some of them

[const1child1,const2child1]=constrains(child1);
totalConst1Child1=abs(const1child1)+abs(const2child1);
[const1child2,const2child2]=constrains(child2);
totalConst1Child2=abs(const1child2)+abs(const2child2);


if totalConst1Child1>=totalConst1Child2
   if totalConst1Child2<totalConst1Parent1
       if totalConst1Child2<totalConst1Parent2
           newParent1=child2;
       else
           newParent1=newParent2;
       end
   elseif totalConst1Parent1>totalConst1Parent2
         newParent1=newParent2;     
   end
else
    if totalConst1Child1<totalConst1Parent1
       if totalConst1Child1<totalConst1Parent2
           newParent1=child1;
       else
           newParent1=newParent2;
       end
   elseif totalConst1Parent1>totalConst1Parent2
         newParent1=newParent2;     
   end
    
end

if totalConst1Child2>=totalConst1Child2
   if totalConst1Child2<totalConst1Parent1
       if totalConst1Child2<totalConst1Parent2
           newParent2=child2;
       end
   elseif totalConst1Parent1<totalConst1Parent2
         newParent2=[newParent1(1)+alpha,newParent1(2)+alpha]; 
   end
   
else
    if totalConst1Child1<totalConst1Parent1
       if totalConst1Child1<totalConst1Parent2
           newParent2=[child1(1)+alpha,child1(2)+alpha];
       end
   elseif totalConst1Parent1<totalConst1Parent2
         newParent2=[newParent1(1)+alpha,newParent1(2)+alpha];     
   end
    
end
end

