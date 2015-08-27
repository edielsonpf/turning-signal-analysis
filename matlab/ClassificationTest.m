expected=[
2
2
2
2
2
2
2
3
3
3
3
3
3
3
1
1
1
1
1
1
1
1
1
1
1
1
1
1
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
3
3
3
3
3
3
3
3
3
3
3
3
3
3
2
2
2
2
2
2
2  
];

%trainning model 1
disp('Starting trainning procedure....');
disp('Training model 1:');
file_name = 'group1_pca.txt';
model1 = TrainGmmModel(file_name);

disp('Training model 2:');
file_name = 'group2_pca.txt';
model2 = TrainGmmModel(file_name);

disp('Training model 3:');
file_name = 'group3_pca.txt';
model3 = TrainGmmModel(file_name);

disp('Starting testing procedure....');
file_list='file_test_list.txt';

%teting
disp('Testing model 1:');
result1=TestGmmModel(file_list,model1);
disp(result1);
disp('Testing model 2:');
result2=TestGmmModel(file_list,model2);
disp(result2);
disp('Testing model 3:');
result3=TestGmmModel(file_list,model3);
disp(result3);

[row,col]=size(result1);
index=[];
%checking
for i=1:row
    maior=result1(i,2);
    index(i)=1;
    if(result2(i,2)> maior)
        maior=result2(i,2);
        index(i)=2;
    end
    if(result3(i,2)> maior)
        maior=result3(i,2);
        index(i)=3;
    end
end
disp(index');
disp(expected);
success=(index'==expected);
disp(success);