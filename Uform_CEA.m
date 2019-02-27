function [result] = Uform_CEA (P, V, U)
    fid = fopen ('ICE_CEA.inp', 'w');
    fprintf (fid, ' prob case=01591743 tp \n\n');
    fprintf (fid, '   p(bar) = %f \n', P);
    fprintf (fid, '   t,k= = %f \n', 298.15);
    fprintf (fid, ' reac \n');
    fprintf (fid, '   name Air             wt%%= 93.80 \n');
    fprintf (fid, '   name C8H18,isooctane wt%%=  6.20 \n');
    fprintf (fid, ' output massf \n');
    fprintf (fid, ' output trace=1e-51 \n');
    fprintf (fid, ' end \n');
    fclose(fid);
    
    system('FCEA2.exe < command.txt');
    
    text = fileread('ICE_CEA.out');
    text = extractAfter(text,strfind(text,'S, KJ/(KG)(K)')+17);
    text = extractBefore(text,strfind(text,'M, (1/n)')-4);
    S_std = str2double(text);
    
    fid = fopen ('ICE_CEA.inp', 'w');
    fprintf (fid, ' prob case=01591743 sv \n\n');
    fprintf (fid, '   s/r = %f \n', (S_std/8.3144621));
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
    text = extractAfter(text,strfind(text,'U, KJ/KG')+15);
    text = extractBefore(text,strfind(text,'G, KJ/KG')-3);
    U_std = str2double(text);
    U_form = -U_std+U;
    
    [result] = U_form;
end