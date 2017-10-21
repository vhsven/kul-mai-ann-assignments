function num = detect_num(T, input)
    for num=0:9
       template = T(:,1+num);
       if template == input
          return; 
       end
    end
    num = -1;
end

