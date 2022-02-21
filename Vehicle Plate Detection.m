clear; 
clc;
close all;
original_img = imread('image 1.jpg');   

imshow(original_img),title("orignal image")

gray_img = imbinarize(rgb2gray(original_img));
props_img= regionprops(gray_img,'area', 'BoundingBox');
props_len=length(props_img)


if(props_len==18) %case image 2_T3
    
    Img1=original_img(1:size(original_img,1)/2,1:size(original_img,2)/2,:);
    Img2=original_img(size(original_img,1)/2+1:size(original_img,1),1:size(original_img,2)/2,:);
    Img3=original_img(1:size(original_img,1)/2,size(original_img,2)/2+1:size(original_img,2),:);
    Img4=original_img(size(original_img,1)/2+1:size(original_img,1),size(original_img,2)/2+1:size(original_img,2),:);
    
    Img1=rotate2(Img1)
    Id = imcrop(Img1,[13 10 129 73]);     
    Img1=Id 
    Id = imcrop(Img2,[17 2 122 65]);     
    Img2=Id
    
   
   image{1}=Img1
   image{2}=Img2
   image{3}=Img3
   image{4}=Img4

    for img=1:4
        count=0;
        original_img=image{img}
        photo_color=color(original_img);
        
        gray_img = imbinarize(rgb2gray(original_img));
        figure,imshow(original_img),title(photo_color)
        hold on;
       props = regionprops(gray_img,'area', 'BoundingBox');
       for k= 2: length(props)-1
            thisBB = props(k).BoundingBox;
            rectangle('Position',thisBB,'EdgeColor','g','LineWidth',2 )
       end
       hold off;
      
       for i =1:length(props)
            border=props(i);
            object_X=border.BoundingBox(1);
            object_Y=border.BoundingBox(2);
            object_W=border.BoundingBox(3);
            object_H=border.BoundingBox(4);
            if(object_H>=30 &&object_H<50 )
                cropped_photo=imcrop(original_img,[object_X,object_Y,object_W-1,object_H-1]);
                if(count==0) 
                    count=1;
                    num_photo = cropped_photo;
                    n_numbers=img_detection(num_photo)
                
                else 
                char_photo=cropped_photo;
                n_characters=img_detection(char_photo)
                
                end
        end
       end
      figure,imshow(num_photo),title("numbers count is : "+n_numbers);
      figure,imshow(char_photo),title("char count is: "+ n_characters);
      carinfo(original_img,photo_color,n_characters,n_numbers);

    end

elseif(props_len>18)
    Img1=original_img(1:size(original_img,1)/2,1:size(original_img,2)/2,:);
    Img2=original_img(size(original_img,1)/2+1:size(original_img,1),1:size(original_img,2)/2,:);
    Img3=original_img(1:size(original_img,1)/2,size(original_img,2)/2+1:size(original_img,2),:);
    Img4=original_img(size(original_img,1)/2+1:size(original_img,1),size(original_img,2)/2+1:size(original_img,2),:);

     Id = imcrop(Img2,[7 0 117 112]);     
     Img2=Id
     Id = imcrop(Img4,[13 0 123 112]);
     Img4=Id
 
   image{1}=Img1
   image{2}=Img2
   image{3}=Img3
   image{4}=Img4

    for Img=1:4      
        count=0;
        original_img=image{Img}
        photo_color=color(original_img);
        
        gray_img = imbinarize(rgb2gray(original_img));
        figure,imshow(original_img),title(photo_color)
        hold on;
       props = regionprops(gray_img,'area', 'BoundingBox');
       for k= 1: length(props)
            thisBB = props(k).BoundingBox;
            rectangle('Position',thisBB,'EdgeColor','g','LineWidth',2 )
       end
       hold off;
       for i =2:length(props)-1
            border=props(i);
            object_X=border.BoundingBox(1);
            object_Y=border.BoundingBox(2);
            object_W=border.BoundingBox(3);
            object_H=border.BoundingBox(4);
            if(object_H>=35 &&object_H<50 )
                cropped_photo=imcrop(original_img,[object_X,object_Y,object_W-1,object_H-1]);
                if(count==0) 
                    count=1;
                    num_photo = cropped_photo;
                    n_numbers=img_detection(num_photo)
                else 
                char_photo=cropped_photo;
                n_characters=img_detection(char_photo)
                end
        end
       end
 figure,imshow(num_photo),title("numbers count is : "+n_numbers);
      figure,imshow(char_photo),title("char count is: "+ n_characters);
       carinfo(original_img,photo_color,n_characters,n_numbers);
    end
else %case single photo

photo_color=color(original_img)

if props_len==3 % case red photo
   original_img = imcrop(original_img,[12 0 113 112]);% case image red T1
end
if(props_len==11)
original_img= rotate(original_img)
Id = imcrop(original_img,[15 38 180 112]);
photo_color=color(Id)     
end

figure,imshow(original_img),title(photo_color)
gray_img = imbinarize(rgb2gray(original_img));
props = regionprops(gray_img,'area', 'BoundingBox');

hold on
for k = 1 : length(props)
    rectangle('Position', props(k).BoundingBox, 'EdgeColor', 'g');
end
hold off;

count=0;
for i =2:length(props)-1
  
border=props(i);
object_X=border.BoundingBox(1);
object_Y=border.BoundingBox(2);
object_W=border.BoundingBox(3);
object_H=border.BoundingBox(4);
    if(object_H>=35&&object_H<80)
    cropped_photo=imcrop(original_img,[object_X,object_Y,object_W-1,object_H-1]);
        if(count==0) 
            count=1;
            num_photo = cropped_photo;
            n_numbers=img_detection(num_photo)
        
        else 
            char_photo=cropped_photo;
            n_characters=img_detection(char_photo)

        end
    else
        continue
    end
end
 figure,imshow(num_photo),title("numbers count is : "+n_numbers);
 figure,imshow(char_photo),title("char count is: "+ n_characters);
 carinfo(original_img,photo_color,n_characters,n_numbers);
end

function p=color(I)
    [rows, columns, numberOfColorChannels] = size(I);

    x=0;
    gray=0
    for row = 1:rows
        for col = 1:columns
            r=I(row, col, 1);
            g=I(row, col, 2);
            b=I(row, col, 3);
           
            if(r==157)&&(g==16)&&(b==7)
                 p='red'
                x=1;
                break;             
             elseif(r==5)&&(g==75)&&(b==25)
                 p='orange'
                x=1;
                break
            elseif(((5<=r)&&(r<=15))&&((75<=g)&&(g<=90))&&((185<=b)&&(b<=205)))||((1<=r)&&(r<=10))&&((110<=g)&&(g<=135))&&((220<=b)&&(b<=270))||((25<=r)&&(r<=35))&&((90<=g)&&(g<=120))&&((140<=b)&&(b<=160))
                p='blue'
               x=1;
               break;
               elseif((190<=r)&&(r<=205))&&((200<=g)&&(g<=210))&&((210<=b)&&(b<=225))
                gray=gray+1
                if(gray>10)
                p='gray'
                x=1;
                break;
                end
                continue;

            else
                p='cannot get color'
            end
        end
        if x ==1
            break;
        end
    end
end
function p=rotate(I)

J = imrotate(I,-20,'bilinear','crop');
p=J

end

function p=rotate2(I)
J = imrotate(I,-13,'bilinear','crop');
p=J
title('Rotated Image');
end

function p=img_detection(photo)


counter=0;
[rows, columns, numberOfColorChannels] = size(photo);


last_col=0;
for i=3:columns-3
    for j=5:rows-5

        if ((photo(j,i,1)<200) && (i-last_col>2))
            counter=counter+1;
            last_col=i;
            continue
        elseif (photo(j,i,1)<200)
            last_col=i;
            continue
        end       
    end
end
p=counter;
end
function p=carinfo(img,color,charcount,numcount)
    if(color=="red")
        x=color+" / Transport /";
        %figure,imshow(img),title(color+" Transport")
    elseif(color=="orange")
        %figure,imshow(img),title(color+" Taxi")
        x=color+" / Taxi /";
    elseif(color=="blue")
         %figure,imshow(img),title(color+" Owners cars")
         x=color+" / Owners cars /";
    elseif(color=="gray")
        x=color+" / Government  cars /";
         %figure,imshow(img),title(color+" Government  cars")
    end
    if(charcount+numcount==6&&numcount==3)
        x=x+" Cairo"
    elseif(charcount+numcount==6&&numcount==4)
        x=x+" Giza"
    elseif(charcount+numcount==7&&numcount==4)
        x=x+" Other governorate "
    end
     figure,imshow(img),title(x)
end