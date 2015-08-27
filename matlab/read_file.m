function read_file(szFileName)

	val = zeros(1,9);
%	fid1 = fopen("vc_200_f_02_ap_015.perfil","r");
	fid1 = fopen(szFileName,'r');
	obs=0;
	[val1,count] = fread(fid1,1,'int');
	disp(val1);
	count=1;	
	while count~=0 
		[val,count] = fread(fid1,val1,'double');
		if(count ~=0)		
			%for i=1:count
			%	disp(val(i));
			%end
            %disp('\n');
            disp(val);
			obs=obs+1;
		end
    end
    string = sprintf('\nObs: %d\n', obs);
    disp(string);
	fclose(fid1);
end