I1=imread('jump.jpg');

I2=imread('jump2.jpg');

figure,imshow(I1),title('img1');

figure,imshow(I2),title('img2');
man=imgaussfilt(I1,0.5);
[h, w, c] = size(man);

s = zeros(h,w,c);
for i=1:h
    for j = 1:w
        if man(i,j,1) > 20 && man(i,j,2) >46 && man(i,j,3) >90 
            s(i,j,:) = man(i,j,:);
        end
    end
end

Z = imdilate(~s,ones(4,4));
BWdfill = imfill(Z,'holes');
BWnobord = imclearborder(BWdfill,4);
% newI1 >> image I1 after segmentation
newI1=imfill(BWnobord,'holes'); % white man for I2
% negnewI1 >> negative g
negNewI1=imfill(~BWnobord,'holes');% color man for I1

%for original image >> I1
intI1 = im2uint8(I1);
resizeI1 = imresize(intI1,[480,319]);
%for negNewI1
intNegNewI1 = im2uint8(negNewI1);
resize_negNewI1 = imresize(intNegNewI1,[480,319]);
%add I1 to negNewI1 
color_man=imadd(resize_negNewI1,resizeI1); %color man

%for original image >> I2
%for NewI1
intNewI1 = im2uint8(newI1);
resize_NewI1 = imresize(intNewI1,[480,319]);

intI2=im2uint8(I2);
resizeI2 = imresize(intI2,[480,319]);
%add I2 to NewI1
hotel=imadd(resize_NewI1,resizeI2);
figure,imshowpair(hotel,color_man,'montage');









[h,w,s1]=size(color_man);
I=im2double(color_man);

[h1,w1,s]=size(hotel);
I2=im2double(hotel);
ch=0;
cw=0;

if h1>h
    ch=h1;
else
    ch=h;
end

if w1>w
    cw=w1;
else
    cw=w;
end
comp=ones(ch,cw,s);

for i=1:h
    for j=1:w
        if I(i,j)==255
            I(i,j)=0;
        end
        
        
    end
end


for i=1:h1
    for j=1:w1
        if I2(i,j)==255
            I2(i,j)=0;
        end
       
    end
end



for i=1:h
    for j=1:w
         comp(i,j,:)=I(i,j,:);

    end
end

comp_img=zeros(h1,w1,s);
comp_img=comp.*I2;


% figure,imshow(I),title('figuer1');
% figure,imshow(I2),title('figuer2');


figure,imshow(comp_img),title('combination image');



