limit=5;
timestep=10;
address='google.com';
tic
for i=1:limit
    answer=[];
    status=[];
    [~,answer]=dos(['ping ' address]);
    position1=strfind(answer, 'time=');
    position2=strfind(answer,'ms ');
    curtime=floor(clock);
    hour=num2str(curtime(4));
    min=num2str(curtime(5));
    sec=num2str(curtime(6));
    if isempty(position2)
        disp(['Error at ' hour ':' min ':' sec '  ' date])
        time=-1;
    else
        for x=1:4
            time(x)=str2double(answer(position1(x)+5:position2(x)-1));
        end
    end

    timeavg(i,1)=toc/60;
    timeavg(i,2)=mean(time);
    
    figure(1)
    hold on
    if i>1
        plot([timeavg(i-1,1) timeavg(i,1)],[timeavg(i-1,2) timeavg(i,2)])
    end
    plot(timeavg(i,1),timeavg(i,2),'Marker','^','Color','g');

    xlabel('Minutes');
    ylabel('ms');
    title(['Ping times to ' address])
    line([0 timeavg(i,1)],[0 0],'Color','r');
    
    pause(timestep)
end