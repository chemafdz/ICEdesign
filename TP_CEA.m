function [result] = TP_CEA (P, T)
    fid = fopen ('ICE_CEA.inp', 'w');
    fprintf (fid, ' prob case=01591743 tp \n\n');
    fprintf (fid, '   p(bar) = %f \n', P);
    fprintf (fid, '   t,k= = %f \n', T);
    fprintf (fid, ' reac \n');
    fprintf (fid, '   name Air             wt%%= 93.80 \n');
    fprintf (fid, '   name C8H18,isooctane wt%%=  6.20 \n');
    fprintf (fid, ' output massf \n');
    fprintf (fid, ' output trace=1e-51 \n');
    fprintf (fid, ' end \n');
    fclose(fid);
    
    commandfile = fopen('command.txt', 'w');
    fprintf (commandfile, 'ICE_CEA\n');
    fclose (commandfile);
    
    system('FCEA2.exe < command.txt');
    
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'RHO')+15);
    text = extractBefore(text,strfind(text,'H, KJ/KG')-5);
    RHO = str2double(text);
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'U, KJ/KG')+15);
    text = extractBefore(text,strfind(text,'G, KJ/KG')-3);
    U = str2double(text);
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'S, KJ/(KG)(K)')+17);
    text = extractBefore(text,strfind(text,'M, (1/n)')-4);
    S = str2double(text);
    V = RHO^-1;
    
    [result] = [T, P, V, U, S];
end