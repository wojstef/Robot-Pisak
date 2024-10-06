function ustawieniexy22() 
%#codegen

 x = 0;        %pozycja x
 y = 14;       %pozycja y
 n = 'A';      %wybór litery
 font = 1;     %rozmiar czcionki
 pp = 2;         %liczba powtórzeń
 
r = raspi();
s0 = servo(r, 18,'MinPulseDuration',5e-4,'MaxPulseDuration',2e-3);
s1 = servo(r, 4,'MinPulseDuration',5e-4,'MaxPulseDuration',2e-3);
s2 = servo(r, 6,'MinPulseDuration',5e-4,'MaxPulseDuration',2e-3);
s3 = servo(r, 12,'MinPulseDuration',5e-4,'MaxPulseDuration',2e-3);
   

tan_krok = linspace(-1.7321,1.7321,601);  
kat0 = linspace(0,180,601);
kat1 = linspace(120,80,115);
kat2 = linspace(5,80,115);
l = (20.2:0.1:8.8);

function b = getst0(x,y) 
    
    tan_sita = -x/y;
    for k = 1:601
        if tan_sita >= tan_krok(k) && tan_sita <= tan_krok(k+1)
            break;
        end
    end
    if k >= 601
        k = 601;
         b = 601;
    else
        b = k;
    end
end

function a = getst12(x ,y) %#codegen
  
    radius = sqrt(x.*x+y.*y);
    for i = 1:115
        if radius <= l(i) && radius >= l(i+1)
            break; 
        end 
    end
    if i >= 115
        i = 115;
        a = 115;
    else
        a = i; 
    end
end
    
function setxy(x, y, down) %#codegen
   
    
    c2 = getst12(x,y);
    c1 = getst0(x,y);
    
    if down == 1                                       %put down the pen
        writePosition(s1, kat1(c2));                            %servo1
        pause(0.5);
        writePosition(s0, kat0(c1));                              %servo0
        writePosition(s2, kat2(c2));                              %servo2
        writePosition(s3, 90 - kat2(c2)-kat1(c2));                            %servo3
        pause(0.5);
    else
        writePosition(s1, kat1(c2+5));                            %servo1
        pause(0.5);
        writePosition(s0, kat0(c1));                              %servo0
        writePosition(s2, kat2(c2));                              %servo2
        writePosition(s3, 90 - kat2(c2)-kat1(c2));                            %servo3
        pause(0.5);
    end
    pause(1)
end

function writexy(x, y)  %#codegen

    c2 = getst12(x,y);
    c1 = getst0(x,y);
    
    writePosition(s0, kat0(c1-5));                                               
    writePosition(s1, kat1(c2));                                               
    writePosition(s2, kat2(c2));                                               
    writePosition(s3, 90 - kat2(c2)-kat1(c2));                                             
    pause(0.1);
    
end

function drawline(x1,y1,x2,y2) %#codegen
       
    stepx = (x2-x1)/100.0;
    stepy = (y2-y1)/100.0;
    writexy(x1,y1);
    for i = 0 : 100
        x1 = x1 + stepx;
        y1 = y1 + stepy;
        writexy(x1,y1);
    end
end
  
    switch n
        case '0'
            for p = 1:pp
                setxy(x,y,1);
                drawline(x,y,x+font,y);
                pause(1)
                drawline(x+font,y,x+font,y-font*2);
                pause(1)
                drawline(x+font,y-font*2,x,y-font*2);
                pause(1)
                drawline(x,y-font*2,x,y);   
                setxy(x,y,0);
            end
        case '1'
            for p = 1:pp
                setxy(x,y,1);
                drawline(x,y,x,y-font*2);
                setxy(x,y-font*2,0);
            end
        case '2'
            for p = 1:pp
                setxy(x,y,1);
                drawline(x,y,x+font,y);
                drawline(x+font,y,x+font,y-font);
                drawline(x+font,y-font,x,y-font);
                drawline(x,y-font,x,y-font*2);   
                drawline(x,y-font*2,x+font,y-font*2);  
                setxy(x+font,y-font*2,0);
                pause(2)
            end
        case '3'
            for p = 1:pp
                setxy(x,y,1);
                drawline(x,y,x+font,y);
                drawline(x+font,y,x+font,y-font*2);
                drawline(x+font,y-font*2,x,y-font*2);
                setxy(x,y-font,1);
                drawline(x,y-font,x+font,y-font);    
                setxy(x+font,y-font,0);
                pause(2)
            end
            
        case '4'
                setxy(x,y,1);
                drawline(x,y,x,y-font);
                drawline(x,y-font,x+font,y-font);
                drawline(x+font,y-font,x+font,y);
                drawline(x+font,y,x+font,y-font*2);
                setxy(x+font,y-font*2,0);
         
        case '5'
                setxy(x+font,y,1);
                drawline(x+font,y,x,y);
                drawline(x,y,x,y-font);
                drawline(x,y-font,x+font,y-font);
                drawline(x+font,y-font,x+font,y-font*2);
                drawline(x+font,y-font*2,x,y-font*2);
                setxy(x,y-font*2,0);
            
        case '6'
            for p = 1:pp
                setxy(x+font,y,1);
                drawline(x+font,y,x,y);
                drawline(x,y,x,y-font*2);
                drawline(x,y-font*2,x+font,y-font*2);
                drawline(x+font,y-font*2,x+font,y-font);
                drawline(x+font,y-font,x,y-font);
                setxy(x,y-font,0);
            end
        case '7'
            for p = 1:pp
                setxy(x,y,1);
                drawline(x,y,x+font,y);
                drawline(x+font,y,x+font,y-font*2);
                setxy(x+font,y-font*2,0);
            end
        case '8'
            for p = 1:pp
                setxy(x,y-font,1);
                drawline(x,y-font,x,y);
                drawline(x,y,x+font,y);
                drawline(x+font,y,x+font,y-font*2);
                drawline(x+font,y-font*2,x,y-font*2);
                drawline(x,y-font*2,x,y-font);
                drawline(x,y-font,x+font,y-font);
                setxy(x+font,y-font,0);
            end
        case '9'
            for p = 1:pp
                setxy(x+font,y-font,1);
                drawline(x+font,y-font,x,y-font);
                drawline(x,y-font,x,y);
                drawline(x,y,x+font,y);
                drawline(x+font,y,x+font,y-font*2);
                drawline(x+font,y-font*2,x,y-font*2);
                setxy(x,y-font * 2,0);
            end
        case 'A'
            for p = 1:pp
                setxy(x,y-font*2,1);
                drawline(x,y-font*2,x+font,y);
                drawline(x+font,y,x+font,y-font*2);
                setxy(x,y-font,1);
                drawline(x,y-font,x+font,y-font);
                setxy(x+2*font,y-font,0);
            end
            
        case 'B'
            for p = 1:pp
                setxy(x,y,1);
                drawline(x,y,x,y - font*2);
                drawline(x,y - font*2,x+font,y-3 * font/2);
                drawline(x+font,y-3 * font/2,x,y-font);
                drawline(x,y-font,x + font,y-font/2);
                drawline(x + font,y-font/2,x,y);
                setxy(x,y,0);
            end
        case 'C'
            for p = 1:pp
                setxy(x+font,y,1);
                drawline(x+font,y,x,y);
                drawline(x,y,x,y-font*2);
                drawline(x,y-font*2,x+font,y-font*2);
                setxy(+font,y-font*2,0);
            end
        case 'D'
            for p = 1:pp
                setxy(x,y,1);
                drawline(x,y,x,y - font*2);
                drawline(x,y - font*2,x+font,y-3 * font/2);
                drawline(x+font,y-3 * font/2,x + font,y-font/2);
                drawline(x + font,y-font/2,x ,y);
                setxy(x,y,0);
            end
        case 'E'
            for p = 1:pp
                setxy(x+font,y,1);
                drawline(x+font,y,x,y);
                drawline(x,y,x,y-font*2);
                drawline(x,y-font*2,x+font,y-font*2);
                setxy(x+font,y-font,1);
                drawline(x+font,y-font,x,y-font);    
                setxy(x,y-font,0);
            end
        
        case 'F'
            setxy(x+font,y,1);
            drawline(x+font,y,x,y);
            drawline(x,y,x,y-font*2);
            setxy(x+font,y-font,1);
            drawline(x+font,y-font,x,y-font);    
            setxy(x,y-font,0);
        case 'G'
            setxy(x+font,y,1);
            drawline(x+font,y,x,y);
            drawline(x,y,x,y-font*2);
            drawline(x,y-font*2,x+font,y-font*2);
            drawline(x+font,y-font*2,x+font,y-font);
            drawline(x+font,y-font,x +font/2,y-font);
            setxy(x+font/2,y-font,0);
  
        case 'H'
            setxy(x,y,1);
            drawline(x,y,x,y-font*2);
            setxy(x+font,y,1);
            drawline(x + font,y,x+font,y-font*2);
            setxy(x+font,y-font,1);
            drawline(x+font,y-font,x,y-font);
            setxy(x,y-font,0);

        case 'I'
            setxy(x,y,1);
            drawline(x,y,x+font,y);
            setxy(x+font/2,y,1);
            drawline(x+font/2,y,x+font/2,y-font*2);
            setxy(x+font,y-font*2,1);
            drawline(x+font,y-font*2,x,y-font*2);    
            setxy(x,y-font*2,0);

        case 'J'
            setxy(x+font,y,1);
            drawline(x+font,y,x+font,y-font*2);
            drawline(x+font,y-font*2,x+0.2*font,y-font*2);
            drawline(x,y-font*2,x,y-3*font/2);    
            setxy(x,y-font,0);

        case 'K'
            setxy(x,y,1);
            drawline(x,y,x,y - font*2);
            setxy(x+font,y-font*2,0);
            drawline(x+font,y-font*2,x,y-font);
            drawline(x,y-font,x+font,y);
            setxy(x+font,y,0);

        case 'L'
            setxy(x,y,1);
            drawline(x,y,x,y-font*2);
            drawline(x,y-font*2,x+font,y-font*2);
            pause(1)
            setxy(x+font,y-font*2,0);
  
        case 'M'
            setxy(x,y-font*2,1);
            pause(0.5)
            drawline(x,y-font*2,x+0.25*font,y);
            pause(0.5)
            drawline(x+0.25*font,y,x+0.5*font,y-2*font);
            pause(0.5)
            drawline(x+0.5*font,y-2*font,x+0.75*font,y);
            pause(0.5)
            drawline(x+0.75*font,y,x+font,y-2*font);
            pause(0.5)
            setxy(x+font,y-2*font,0);
            
        case 'N'
            setxy(x,y-font*2,1);
             pause(1)
            drawline(x,y-font*2,x,y);
             pause(1)
            drawline(x,y,x+font,y-font*2);
             pause(1)
            drawline(x+font,y-font*2,x+font, y);
             pause(1)
            setxy(x+font, y,0);
 
        case 'O'
            setxy(x,y,1);
            drawline(x,y,x+font,y);
            drawline(x+font,y,x+font,y-font*2);
            drawline(x+font,y-font*2,x,y-font*2);
            drawline(x,y-font*2,x,y);   
            setxy(x,y,0);

        case 'P'
            setxy(x,y-font,1);
            drawline(x,y-font,x+font,y-font);
            drawline(x+font,y-font,x+font,y);
            drawline(x+font,y,x,y);
            drawline(x,y,x,y-font*2);
            setxy(x,y-font*2,0);

        case 'Q'
            setxy(x+font,y-font,1);
            drawline(x+font,y-font,x,y-font);
            drawline(x,y-font,x,y);
            drawline(x,y,x+font,y);
            drawline(x+font,y,x+font,y-font*2);
            setxy(x+font,y-font*2,0);

        case 'R'
            setxy(x,y-font*2,1);
            drawline(x,y-font*2,x,y);
            drawline(x,y,x+font,y);
            drawline(x+font,y,x+font,y-font);
            drawline(x+font,y-font,x,y-font);
            drawline(x,y-font,x+font,y-font*2);
            setxy(x+font,y-font*2,0);
   
        case 'S'
            setxy(x+font,y,1);
            drawline(x+font,y,x,y);
            drawline(x,y,x,y-font);
            drawline(x,y-font,x+font,y-font);
            drawline(x+font,y-font,x+font,y-font*2);
            drawline(x+font,y-font*2,x,y-font*2);
            setxy(x,y-font*2,0);

        case 'T'
            setxy(x,y,1);
            drawline(x,y,x+font,y);
            setxy(x+font/2,y,1);
            drawline(x+font/2,y,x+font/2,y-2*font);
            setxy(x+font/2,y-2*font,0);

        case 'U'
            setxy(x,y,1);
            drawline(x,y,x,y-2*font);
            drawline(x,y-2*font,x+font,y-2*font);
            drawline(x+2*font,y-2*font,x+2*font,y);
            setxy(x+2*font,y,0);
 
        case 'V'
            setxy(x,y,1);
            drawline(x,y,x+1/2*font,y-2*font);
            drawline(x+1/2*font,y-2*font,x+font,y);
            setxy(x+font,y,0);

        case 'W'
            setxy(x,y,1);
            drawline(x,y,x+0.25*font,y-2*font);
            drawline(x+0.25*font,y-2*font,x+0.5*font,y);
            drawline(x+0.5*font,y,x+0.75*font,y-2*font);
            drawline(x+0.75*font,y-2*font,x+font,y);
            setxy(x+font,y,0);
     
        case 'X'
            setxy(x,y,1);
            drawline(x,y,x+font,y-font*2);
            setxy(x+font,y,1);
            drawline(x+font,y,x,y-font*2);
            setxy(x,y-font*2,0);

        case 'Y'
            setxy(x,y,1);
            drawline(x,y,x+font/2,y-font);
            drawline(x+font/2,y-font,x+font,y);
            drawline(x+font,y,x+font/2,y-font);
            drawline(x+font/2,y-font,x+font/2,y-font*2);
            setxy(x+font/2,y-font*2,0);

        case 'Z'
            setxy(x,y,1);
            drawline(x,y,x+font,y);
            drawline(x+font,y,x+font/2,y-font);
            drawline(x+font/2,y-font,x,y-font*2);
            drawline(x,y-font*2,x+font,y-font*2);
            setxy(x+font,y-font*2,0);

    end
end
