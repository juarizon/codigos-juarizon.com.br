%REPRESENTA Representação de um número decimal em uma base arbritrária
%
%   [M,S,Z]=REPRESENTA(K,B) retorna a representação do decimal K na base B
%   colocando a representação numérica no vetor M, a representação em
%   uma string de soma potências em S e a mesma representação
%   desconsiderando zeros na string Z
%
%   M=REPRESENTA(K) retorna a representação do decimal K na base binária
%   no vetor numérico M
%
if nargin==2
    b=varargin{1};
else
    b=2;
end
s=sprintf('base: %d',b);
disp(s);
m=[];
while k>0
    %k
    %disp('novo algoritmo');
    m=[mod(k,b) m];
    k=floor(k/b);
    %[k m]
    %pause
end;
s='';
z='';
for n=1:length(m);
    %na representação binária, podemos tanto mostrar...
    s=strcat(s, sprintf(' + %d*%d^%d',m(n),b,length(m)-n));
    %... como omitir os zeros
    if(m(n))
        if(m(n)==1)
            z=strcat(z, sprintf(' + %d^%d',b,length(m)-n));
        else
            z=strcat(z, sprintf(' + %d*%d^%d',m(n),b,length(m)-n));
        end
    end
end
s=regexprep(s,'^ \+ ','');
z=regexprep(z,'^ \+ ','');
disp(s);
disp(z);
