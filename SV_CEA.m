function [result] = SV_CEA (S, V)
    fid = fopen ('ICE_CEA.inp', 'w');
    fprintf (fid, ' prob case=01591743 sv \n\n');
    fprintf (fid, '   s/r = %f \n', (S/8.3144621));
    fprintf (fid, '   v,m**3/kg = %f \n', V);
    fprintf (fid, ' reac \n');
    fprintf (fid, '   name Air             wt%%= 93.80 \n');
    fprintf (fid, '   name C8H18,isooctane wt%%=  6.20 \n');
    fprintf (fid, ' output massf \n');
    fprintf (fid, ' output trace=1e-51 \n');
    fprintf (fid, ' end \n');
    fclose(fid);

    system('FCEA2.exe < command.txt');

    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'P, BAR')+17);
    text = extractBefore(text,strfind(text,'T, K')-3);
    P = str2double(text);
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'T, K')+17);
    text = extractBefore(text,strfind(text,'RHO, KG/CU M')-3);
    T = str2double(text);
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'U, KJ/KG')+15);
    text = extractBefore(text,strfind(text,'G, KJ/KG')-3);
    U = str2double(text);
    
    [result] = [T, P, V, U, S];
end