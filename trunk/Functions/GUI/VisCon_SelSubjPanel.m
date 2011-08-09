function VisCon_SelSubjPanel()
global gVisConFig;
global gVisConNet;

hFig = findobj('Tag','VisConFig');
hSubjSelPanel = findobj(hFig, 'Tag','SubjSelPanel');
if ~isempty(hSubjSelPanel)
    delete(hSubjSelPanel);
end

FigPos = get(hFig, 'Position');
nSubj = length(gVisConNet);
if(nSubj == 1)
    return;
end

hSubjSelPanel = uipanel('Parent',hFig,...
    'Units','pixels',...
    'Tag','SubjSelPanel',...
    'Clipping','on',...
    'Position',[FigPos(3)/2-150 FigPos(4)-62 300 64]);

uicontrol('Parent',hSubjSelPanel,...
    'Position',[100 43 100 16],...
    'String','Subject Picker',...
    'Style','text', 'FontSize', 8, 'FontWeight','bold');

hSubjSelSilder = uicontrol('Parent',hSubjSelPanel,...
    'Position',[25 26 200 16],...
    'String','Drag to select subject.',...
    'Style','slider',...
    'Max',nSubj,...
    'Min',1,...
    'Value',gVisConFig.CurSubj,...
    'SliderStep',[1/(nSubj-1),nSubj/5/(nSubj-1)],...
    'Callback',@SubjSelSilderFcn);
    function SubjSelSilderFcn(Src, Evnt)
        ToSubj = round(get(Src, 'Value'));
        set(Src, 'Value', ToSubj);
        set(hSubjSelEdit,'String', num2str(ToSubj));
        SelectSubj(ToSubj);
    end

uicontrol('Parent',hSubjSelPanel,...
    'Position',[9 26 12 16],...
    'String','1',...
    'Style','text');

uicontrol('Parent',hSubjSelPanel,...
    'Position',[225 26 30 16],...
    'String',num2str(nSubj),...
    'Style','text',...
    'Tag','MaxSubjNumText');

hSubjSelEdit = uicontrol('Parent',hSubjSelPanel,...
    'Position',[255 25 30 20],...
    'Style','edit',...
    'String',num2str(gVisConFig.CurSubj),...
    'BackgroundColor',[1 1 1],...
    'Callback',@SubjSelEditFcn);
    function SubjSelEditFcn(Src, Evnt)
        ToSubj = round(str2double(get(Src, 'String')));
        if ToSubj > length(gVisConNet)
            ToSubj = length(gVisConNet);
        elseif ToSubj < 1
            ToSubj = 1;
        end 
        set(Src,'String', num2str(ToSubj));
        set(hSubjSelSilder,'Value', ToSubj);
        SelectSubj(ToSubj);
    end

uicontrol('Parent',hSubjSelPanel,...
    'Position',[25 3 100 20],...
    'Style','checkbox',...
    'Max',1,...
    'Min',0,...
    'Value',gVisConFig.IdenNodes,...
    'String','Identical Nodes',...
    'Tag','IdenNodesCheck',...
    'Callback',@IdenNodesCheckFcn);
    function IdenNodesCheckFcn(Src, Evnt)
        gVisConFig.IdenNodes = get(Src, 'Value');
    end

uicontrol('Parent',hSubjSelPanel,...
    'Position',[125 3 150 20],...
    'Style','checkbox',...
    'Max',1,...
    'Min',0,...
    'Value',gVisConFig.IdenEdgeThres,...
    'String','Identical Edge Threshold',...
    'Tag','IdenEdgeThresCheck',...
    'Callback',@IdenEdgeThresCheckFcn);
    function IdenEdgeThresCheckFcn(Src, Evnt)
        gVisConFig.IdenEdgeThres = get(Src, 'Value');
    end
uicontrol('Parent',hSubjSelPanel,...
    'Position',[2 45 14 15],...
    'Style','pushbutton',...
    'String','x',...
    'Callback','SubjPicker off');
end


