
function varargout = ev_fiyat_tahmin(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ev_fiyat_tahmin_OpeningFcn, ...
                   'gui_OutputFcn',  @ev_fiyat_tahmin_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function ev_fiyat_tahmin_OpeningFcn(hObject, ~, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

global veriSeti girisVerileri cikisVerileri
veriSeti = xlsread('veriSeti.xlsx');
girisVerileri = transpose(veriSeti(:,1:9));
cikisVerileri = transpose(veriSeti(:,end));
assignin('base','girisVerileri',girisVerileri);
assignin('base','cikisVerileri',cikisVerileri);


function varargout = ev_fiyat_tahmin_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function brut_m2_Callback(hObject, eventdata, handles)

global brutM2
brutM2 = str2double(get(handles.brut_m2,'String'));


function brut_m2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function net_m2_Callback(hObject, eventdata, handles)

global netM2
netM2 = str2double(get(handles.net_m2,'String'));


function net_m2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function oda_sayisi_Callback(hObject, eventdata, handles)

global odaSayisi
odaSayisi = str2double(get(handles.oda_sayisi,'String'));


function oda_sayisi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bina_yasi_Callback(hObject, eventdata, handles)

global binaYasi
binaYasi = str2double(get(handles.bina_yasi,'String'));


function bina_yasi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bulundugu_kat_Callback(hObject, eventdata, handles)

global bulunduguKat
bulunduguKat= str2double(get(handles.bulundugu_kat,'String'));


function bulundugu_kat_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function kat_sayisi_Callback(hObject, eventdata, handles)

global katSayisi
katSayisi = str2double(get(handles.kat_sayisi,'String'));


function kat_sayisi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function isitma_sistemi_Callback(hObject, eventdata, handles)

global isitmaSistemi
contents = cellstr(get(hObject, 'String'));
pop_choice=contents(get(hObject,'Value'));
if(strcmp(pop_choice,'Doðalgaz (Kombi)'))
    isitmaSistemi=1
elseif(strcmp(pop_choice,'Merkezi (Pay Ölçer)'))
    isitmaSistemi=2
elseif(strcmp(pop_choice,'Soba'))
    isitmaSistemi=3
end

function isitma_sistemi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function salon_sayisi_Callback(hObject, eventdata, handles)

global salonSayisi
salonSayisi = str2double(get(handles.salon_sayisi,'String'));


function salon_sayisi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function site_ici_Callback(hObject, eventdata, handles)

global siteIci 
contents = cellstr(get(hObject, 'String'));
pop_choice=contents(get(hObject,'Value'));
if(strcmp(pop_choice,'Evet'))
    siteIci=1
elseif(strcmp(pop_choice,'Hayýr'))
    siteIci=0
end

function site_ici_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hesapla_Callback(hObject, eventdata, handles)

global brutM2 netM2 odaSayisi binaYasi bulunduguKat katSayisi isitmaSistemi salonSayisi siteIci 
girisler = [brutM2; netM2;odaSayisi;salonSayisi;binaYasi;bulunduguKat;katSayisi;isitmaSistemi;siteIci];

load 'egitilmisAg.mat', 'egitilmisAg';
outputTest =  egitilmisAg(girisler);
set(handles.ev_fiyati,'String',outputTest);



function egitim_Callback(hObject, eventdata, handles)

global girisVerileri cikisVerileri

hiddenLayerSize = [10 8];
TF={'logsig','tansig','purelin'};
net = newff(girisVerileri,cikisVerileri,hiddenLayerSize,TF);

net.trainFcn = 'trainlm';
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'dividerand'; 
net.divideMode = 'sample';  
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

net.performFcn = 'mse'; 
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
   'plotregression', 'plotfit'};

net.trainParam.showWindow=true; 
net.trainParam.showCommandLine=false;
net.trainParam.show=10;
net.trainParam.epochs=100;
net.trainParam.goal=1e-3;

[net,tr] = train(net,girisVerileri,cikisVerileri);

ysaCikisVerileri = net(girisVerileri);
fark = gsubtract(cikisVerileri,ysaCikisVerileri);
performans = perform(net,cikisVerileri,ysaCikisVerileri)

assignin('base','ysaCikisVerileri',ysaCikisVerileri);
assignin('base','performans',performans);
assignin('base','fark',fark);

figure, plotregression(cikisVerileri,ysaCikisVerileri);

egitilmisAg = net;
save('egitilmisAg.mat', 'egitilmisAg');


function ev_fiyati_Callback(hObject, eventdata, handles)


function ev_fiyati_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function egitimGizle_Callback(hObject, eventdata, handles)
if(get(hObject,'Value')==get(hObject,'Max'))
    set(handles.egitim, 'visible','off')
    set(handles.egitimGizle,'visible','off')
    set(handles.egitimGoster,'visible','on')
    set(handles.egitimGizle,'value',0)
    set(handles.hesapla,'Position',[9.6 26.538 90.2 5.385])
    set(handles.ev_fiyati,'Position',[9.6 13.077 90.2 6.692])
    set(handles.ev_fiyati_label,'Position',[9.8 20 90.2 2.385])
end

function egitimGoster_Callback(hObject, eventdata, handles)
if(get(hObject,'Value')==get(hObject,'Max'))
    set(handles.egitim, 'visible','on')
    set(handles.egitimGizle,'visible','on')
    set(handles.egitimGoster,'visible','off')
    set(handles.egitimGoster,'value',0)
    set(handles.egitim,'Position',[9.8 33.077 90.2 5.385])
    set(handles.hesapla,'Position',[9.6 21.538 90.2 5.385])
    set(handles.ev_fiyati,'Position',[9.6 6.077 90.2 6.692])
    set(handles.ev_fiyati_label,'Position',[9.8 13 90.2 2.385])
end
