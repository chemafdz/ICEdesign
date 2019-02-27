function [result] = UV_CEA (U, V)
    fid = fopen ('ICE_CEA.inp', 'w');
    fprintf (fid, ' prob case=01591743 uv \n\n');
    fprintf (fid, '   u/r = %f \n', (U/8.3144621));
    fprintf (fid, '   v,m**3/kg = %f \n', V);
    fprintf (fid, ' reac \n');
    fprintf (fid, '   name Air             wt%%= 93.80 t,k = 298.15 \n');
    fprintf (fid, '   name C8H18,isooctane wt%%=  6.20 t,k = 298.15 \n');
    fprintf (fid, ' output massf \n');
    fprintf (fid, ' output trace=1e-3 \n');
    fprintf (fid, ' end \n');
    fclose(fid);
    
    system('FCEA2.exe < command.txt');
    
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'P, BAR')+17);
    text = extractBefore(text,strfind(text,'T, K')-3);
    P = str2double(text);
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'T, K')+16);
    text = extractBefore(text,strfind(text,'RHO, KG/CU M')-3);
    T = str2double(text);
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'S, KJ/(KG)(K)')+17);
    text = extractBefore(text,strfind(text,'M, (1/n)')-4);
    S = str2double(text);
    
    [result] = [T, P, V, U, S];
end