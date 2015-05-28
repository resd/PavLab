function [ out, res1, a ] = getsingleout( v2, cl1t, cl2t, t1Len )
%GETOUT Summary of this function goes here
%   Detailed explanation goes here
clc;
switch v2
    case 1% MSR
        %                 [res1, a] = rule_lab2_1(cl1t, cl2t, length(t1));
        %                 disp(res1);
        [res1, a] = rule(cl1t, cl2t, t1Len, false);
        if t1Len == 2
            plotGrapf(a, t1Len, cl1t, cl2t);
        end
        warning('off', 'MATLAB:printf:BadEscapeSequenceInFormat');
        %                 out = sprintf('Метод статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\n\r\nВероятность ошибки 1 рода  =  %f\r\nВероятность ошибки 2 рода  =  %f\r\nРешающие правила:\r\na1 = %f\r\na2 = %f\r\na3 = %f\r\na4 = %f\r\na5 = %f\r\na6 = %f\r\n', res1(1), res1(2), res1(3),res1(4),res1(5),a(1),a(2),a(3),a(4),a(5),a(6));
        out = sprintf('Метод статистических решений:\r\nВероятность правильного разпознавания =  %f\r\nКоличество ошибкок 1 рода  =  %f\r\nКоличество ошибкок 2 рода  =  %f\r\nВероятность ошибки 1 рода  =  %f\r\nВероятность ошибки 2 рода  =  %f\n\n', res1(1), res1(2), res1(3),res1(4),res1(5));
        outStr = sprintf('Коэфициенты уравнения:\n\nСвободный коэфициент:\na[0] = %f\n',a(1));
        outStr = [outStr, sprintf('Линийные коэффициенты:\n')];
        for i = 2:t1Len+1
            tempStr = sprintf('a[%d] = %f\n', (i-1), a(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('Квадратичные коэффициенты:\n')];
        for i = t1Len+2:length(a)
            tempStr = sprintf('a[%d] = %f\n', (i-1), a(i));
            outStr = [outStr, tempStr];
        end
        out = [out, outStr];
        disp(out);
        %                 res2 = Amain(cl1t, cl2t, length(t1));
        %                 disp('МСР+');
        %                 disp(res2);
        % %                 out = sprintf('Модифицированного метод статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\n\r\nРешающие правила:\r\nc = %f\r\na1 = %f\r\na2 = %f\r\na3 = %f\r\na4 = %f\r\na5 = %f\r\na6 = %f', res2(1),res2(2),res2(3),a(7),a(1),a(2),a(3),a(4),a(5),a(6));
        % %                 out = sprintf('Модифицированного метод статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\n\r\nРешающие правила:\r\nc = %f\r\n', res2(1),res2(2),res2(3),res2(4));
        %                 addpath main;
        %                 res4 = Amain4(cl1t, cl2t, length(t1));
        %                 disp('МСР4+');
        %                 disp(res4);
    case 2% mod MSR
        [res1, a] = rule(cl1t, cl2t, t1Len, true);
        if t1Len == 2
            plotGrapf(a, t1Len, cl1t, cl2t);
        end
        warning('off', 'MATLAB:printf:BadEscapeSequenceInFormat');
        %                 out = sprintf('Модифицированного метод статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\n\r\nРешающие правила:\r\nc = %f\r\na1 = %f\r\na2 = %f\r\na3 = %f\r\na4 = %f\r\na5 = %f\r\na6 = %f', res2(1),res2(2),res2(3),a(7),a(1),a(2),a(3),a(4),a(5),a(6));
        out = sprintf('Модифицированного метод статистических решений:\r\nВероятность правильного разпознавания =  %f\r\nКоличество ошибкок 1 рода  =  %f\r\nКоличество ошибкок 2 рода  =  %f\r\nВероятность ошибки 1 рода  =  %f\r\nВероятность ошибки 2 рода  =  %f\n\n', res1(1), res1(2), res1(3),res1(4),res1(5));
        outStr = sprintf('Коэфициенты уравнения:\n\nСвободный коэфициент:\na[0] = %f\n',a(1));
        outStr = [outStr, sprintf('Линийные коэффициенты:\n')];
        for i = 2:t1Len+1
            tempStr = sprintf('a[%d] = %f\n', (i-1), a(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('Квадратичные коэффициенты:\n')];
        for i = t1Len+2:length(a)
            tempStr = sprintf('a[%d] = %f\n', (i-1), a(i));
            outStr = [outStr, tempStr];
        end
        out = [out, outStr];
        disp(out);
    case 3% MSA
        warning('off', 'all');
        %                 MSA(cl1t, cl2t, length(t1));
        [res1, c0, c1max] = MSA(cl1t, cl2t, t1Len, 1);
        if t1Len == 2
            plotGrapf(c1max, t1Len, cl1t, cl2t);
        end
        %[res2, outf, c2, c2max] = MSAnew(cl1t, cl2t, length(t1), 2);
        %                 out = sprintf('Метод стохастической
        %                 апроксимации:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\n
        %                 cLen = (t1Len+1)*(t1Lne+2)/2;
        out = sprintf('Метод стохастической апроксимации:\r\nВероятность правильного разпознавания =  %f\r\nКоличество ошибкок 1 рода  =  %f\r\nКоличество ошибкок 2 рода  =  %f\r\nВероятность ошибки 1 рода  =  %f\r\nВероятность ошибки 2 рода  =  %f\n\n', res1(1), res1(2), res1(3),res1(4),res1(5));
        %                 'Начальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f\r\n', res1(1), res1(2), res1(3),a(1),a(2),a(3),a(4),a(5),a(6),c1max(1),c1max(2),c1max(3),c1max(4),c1max(5),c1max(6));
        %                 outStr = sprintf('Коэфициенты уравнения:\n\nНачальные коэффициенты:\n');
        outStr = sprintf('Коэфициенты уравнения:\n\nНачальные коэффициенты:\nСвободный коэфициент:\na[0] = %f\n',c0(1));
        outStr = [outStr, sprintf('Линийные коэффициенты:\n')];
        for i = 2:t1Len+1
            tempStr = sprintf('a[%d] = %f\n', (i-1), c0(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('Квадратичные коэффициенты:\n')];
        for i = t1Len+2:length(c0)
            tempStr = sprintf('a[%d] = %f\n', (i-1), c0(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('\nКонечные коэффициенты:\nСвободный коэфициент:\na[0] = %f\n',c1max(1))];
        outStr = [outStr, sprintf('Линийные коэффициенты:\n')];
        for i = 2:t1Len+1
            tempStr = sprintf('a[%d] = %f\n', (i-1), c1max(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('Квадратичные коэффициенты:\n')];
        for i = t1Len+2:length(c1max)
            tempStr = sprintf('a[%d] = %f\n', (i-1), c1max(i));
            outStr = [outStr, tempStr];
        end
        outStr2 = sprintf('\nРезультат найден на цикле обучения: %d из %d%d\r\n',res1(6),res1(7));
        out = [out, outStr, outStr2];
        %Метод стохастической апроксимации с коэффициентами из
        %метода статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nНачальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f
        %,res2(1),res2(2),res2(3),c2(1),c2(2),c2(3),c2(4),c2(5),c2(
        %6),c2max(1),c2max(2),c2max(3),c2max(4),c2max(5),c2max(6));
        disp(out);
    case 4% MSA + MSR
        [res1, c0, c1max] = MSA(cl1t, cl2t, t1Len, 2);
        if t1Len == 2
            plotGrapf(c1max, t1Len, cl1t, cl2t);
        end
        %[res2, outf, c2, c2max] = MSAnew(cl1t, cl2t, length(t1), 2);
        %                 out = sprintf('Метод стохастической апроксимации с коэффициентами из метода статистических решений:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nНачальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f\r\nРезультат найден на цикле обучения: %d из %d%d\r\n', res1(1), res1(2), res1(3),a(1),a(2),a(3),a(4),a(5),a(6),c1max(1),c1max(2),c1max(3),c1max(4),c1max(5),c1max(6),res1(4),res1(5));
        out = sprintf('Метод стохастической апроксимации с коэффициентами из метода статистических решений:\r\nВероятность правильного разпознавания =  %f\r\nКоличество ошибкок 1 рода  =  %f\r\nКоличество ошибкок 2 рода  =  %f\r\nВероятность ошибки 1 рода  =  %f\r\nВероятность ошибки 2 рода  =  %f\n\n', res1(1), res1(2), res1(3),res1(4),res1(5));
        %                 'Начальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f\r\n', res1(1), res1(2), res1(3),a(1),a(2),a(3),a(4),a(5),a(6),c1max(1),c1max(2),c1max(3),c1max(4),c1max(5),c1max(6));
        %                 outStr = sprintf('Коэфициенты уравнения:\n\nНачальные коэффициенты:\n');
        outStr = sprintf('Коэфициенты уравнения:\n\nНачальные коэффициенты:\nСвободный коэфициент:\na[0] = %f\n',c0(1));
        outStr = [outStr, sprintf('Линийные коэффициенты:\n')];
        for i = 2:t1Len+1
            tempStr = sprintf('a[%d] = %f\n', (i-1), c0(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('Квадратичные коэффициенты:\n')];
        for i = t1Len+2:length(c0)
            tempStr = sprintf('a[%d] = %f\n', (i-1), c0(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('\nКонечные коэффициенты:\nСвободный коэфициент:\na[0] = %f\n',c1max(1))];
        outStr = [outStr, sprintf('Линийные коэффициенты:\n')];
        for i = 2:t1Len+1
            tempStr = sprintf('a[%d] = %f\n', (i-1), c1max(i));
            outStr = [outStr, tempStr];
        end
        outStr = [outStr, sprintf('Квадратичные коэффициенты:\n')];
        for i = t1Len+2:length(c1max)
            tempStr = sprintf('a[%d] = %f\n', (i-1), c1max(i));
            outStr = [outStr, tempStr];
        end
        outStr2 = sprintf('\nРезультат найден на цикле обучения: %d из %d%d\r\n',res1(6),res1(7));
        out = [out, outStr, outStr2];
        %Метод стохастической апроксимации с коэффициентами из метода статистических решений:\r\nВероятность  =
        %%f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nНачальные коэффициенты:\r\nc1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f;\r\nКонечные коэффициенты:\r\nс1 = %f; c2 = %f; c3 = %f; c4 = %f; c5 = %f; c6 = %f
        %,res2(1),res2(2),res2(3),c2(1),c2(2),c2(3),c2(4),c2(5),c2(
        %6),c2max(1),c2max(2),c2max(3),c2max(4),c2max(5),c2max(6));
        disp(out);
    case 5% Perceptroni
        %                 ini = IniConfig();
        %                 ini.ReadFile('config/config.ini');
        %                 section = '[dataPerceptron]';
        %                 keys = ini.GetKeys(section);
        %                 values = ini.GetValues(section, keys);
        %                 trainCount = values{1};
        [res1, w] = lab5With2Neuron(cl1t, cl2t, t1Len);
        out = sprintf('Перцептрон:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nВесовые коэффициенты W нейронной сети:\r\n%f, %f;\r\n%f, %f\r\nРезультат найден на цикле обучения: %d из %d\r\n',res1(1), res1(2), res1(3),w(1),w(2),w(3),w(4),res1(4),res1(5));
        disp(out);
    case 6% NS
        [res1, a] = lab6DontWork(cl1t, cl2t, t1Len);
        out = sprintf('Однонаправленная нейронная сеть, обучаемаю с применением алгоритма обратного распространения:\r\nВероятность  =  %f\r\nОшибки 1 рода  =  %f\r\nОшибки 2 рода  =  %f\r\nКоличество слоев сети:\r\n%f\r\nКоличество нейронов в каждом слое:\r\n%f',res1(1), res1(2), res1(3),a(1),a(2));
        disp(out);
end

function plotGrapf(c, pr, cl1t, cl2t)
% Отображение полинома в пространстве признаков
if pr == 2 
    tmin = min(min(cl1t(:)), min(cl2t(:)));
    tmax = max(max(cl1t(:)), max(cl2t(:)));
    p = 1000;
    i = 1;
    for t=tmin:((tmax-tmin)/p):tmax,
        z(i)  = t;
        X     = z(i);
        Y1(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
        Y2(i) = (-(c(5) * X + c(2))-((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
        i     = i+1;
    end
    figure(21);
    arrayInd   = [];
    arrayCount = 1;
    flagImag   = false;
    zLen       = length(z);
    for i = 1:zLen
        if isreal(Y1(i)) == 0
            arrayInd(arrayCount) = i;
            arrayCount           = arrayCount + 1;
            flagImag             = true;
        end
    end
    for i = length(arrayInd):-1:1
        z(arrayInd(i))  = [];
        Y1(arrayInd(i)) = [];
        Y2(arrayInd(i)) = [];
    end
    
    plot(cl1t(:,1),cl1t(:,2),'ro',cl2t(:,1),cl2t(:,2),'b+');
    hold on;
    legend('Элементы 1 класса', 'Элементы 2 класса');
    % Вот тут
    plot(z,real(Y1),'-k');
    plot(z,real(Y2),'-k');
    if flagImag
        zLen = length(z);
%         Соеденить конци  Y1 и Y2
        plot([z(1), z(1)],[Y1(1), Y2(1)],'-k');
        plot([z(zLen), z(zLen)],[Y1(zLen), Y2(zLen)],'-k');
    end
    hold off;
end

