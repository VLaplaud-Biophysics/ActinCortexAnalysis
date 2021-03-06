names = {'4s_800nm' '8s_800nm' '4s_1600nm' '8s_1600nm'};


depthoname = 'Deptho_DCmed-7.5pc_301018';

    Zdifftot = [];
    Zreftot = [];
    Zcalctot = [];

nfiles = length(names);

for kn = 1:nfiles
    resfile =  ['D:\Data\Raw\18.10.30\Tracking_' names{kn} '_Results.txt'];
    piffile =  ['D:\Data\Raw\18.10.30\Tracking_' names{kn} '_Pifoc.txt'];
    stackname = ['D:\Data\Raw\18.10.30\Tracking_' names{kn} '.tif'];
    
    [VarName1,Area,Mean,StdDev,Min,Max,X,Y,XM,YM,Major,...
        Minor,Angle1,IntDen,RawIntDen,Slice] = importfileDeptho2(resfile);
    
    [Sdown,Smid,Sup] = SplitZimage(Slice',3);
    
    [Smd,ptrd,ptrm] = intersect(Sdown+1,Smid);
    [Smdu,ptrmd,ptru] = intersect(Smd,Sup-1);
    
    
    l = min([length(Sdown) length(Smid) length(Sup)]);
    
    Sdown = Sdown(ptrd(ptrmd));
    Smid  = Smdu ;
    Sup   = Sup(ptru)  ;
    
    ptrS = ismember(Slice,Smid);
    
    S = Slice(ptrS);
    X1 = XM(ptrS);
    Y1 = YM(ptrS);
    
    
    Zcalc = Zcorr_multiZ(500,XM,X1,YM,Y1,Slice,S,stackname,Sdown,Smid,Sup,depthoname);
    Zcalc = -Zcalc;
    [~,posmax] = max(Zcalc);
   
    [Zreffull,Tfull] = importpifoc(piffile);
    
    Zref = Zreffull(S) - Zreffull(S(posmax)) + Zcalc(posmax);

    
    T = Tfull(S) - Tfull(S(1));

    Zdiff = abs(Zref-Zcalc);

    
Zref = Zref*1000;
Zdiff = Zdiff*1000;
Zcalc = Zcalc*1000;

    figure
    plot(T,Zref,'*-')
    hold on
    plot(T,Zcalc,'-*')
    title(['Mean of diff = ' num2str(mean(Zdiff)) 'nm'])
    xlabel('T (s)')
    ylabel('Z (nm)')
    legend('Zref','Ztrack')

    
    Zdifftot = [Zdifftot Zdiff'];
    Zreftot = [Zreftot Zref'];
    Zcalctot = [Zcalctot Zcalc'];
    
    
end

ptrzerr = (Zdifftot>10)&(Zdifftot<1000)&(Zcalctot>-600);

Zerr = mean(Zdifftot(ptrzerr));

    figure(1000)
    hold on
    plot(Zcalctot,Zdifftot,'r*')
    plot(Zcalctot(ptrzerr),Zdifftot(ptrzerr),'bo')
    title(['Tracking Precision 181030 - Mean error : ' num2str(Zerr) 'nm'])
    ylabel('Tracking error (nm)')
    xlabel('Absolute Z from focus (nm)')
    

