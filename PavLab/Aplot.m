function [  ] = Aplot( class1, class2 , pr)%, z, Y1, Y2
%APLOT Summary of this function goes here
%   Detailed explanation goes here
% for i = 1:pr
%     plot(class1(:,i), 'b+');
%     hold on;
%     plot(class2(:,i), 'ro');
% end
switch pr
    case 3
        plot(class1(:,1),class1(:,2), class1(:, 3),'ro',class2(:,1),class2(:,2), class2(:, 3),'b+');%,z,Y1,'-k', z,Y2,'-k');
        %plot3(class1(:, 1), class1(:, 2), class1(:, 3), 'b+');
        hold on;
        %plot3(class2(:, 1), class2(:, 2), class2(:, 3), 'ro');
    case 2
        plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');%,z,Y1,'-k', z,Y2,'-k'
        %plot(class1(:, 1), class1(:, 2), 'b+');
        hold on;
        %plot(class2(:, 1), class2(:, 2), 'ro');
end


% plot(class1(:, 1), class1(:, 2), 'b+');
% hold on;
% plot(class2(:, 1), class2(:, 2), 'ro');



%plot (1.8162, 0:0.001:2.5) %По идее тут должно быть
%plot (0:0.001:2.5, 1.8162) %кокое-то граничное значение
% Aplot(cl1, cl2, 1)
% Aplot(cl1, cl2, 2)

end

