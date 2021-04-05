
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
girisler



function egitim_Callback(hObject, eventdata, handles)


function ev_fiyati_Callback(hObject, eventdata, handles)


function ev_fiyati_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

