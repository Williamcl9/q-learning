function tree = ID3_New(Features)
    size(Features, 1)
    tree.kids = cell(1,2);
    %Examples(~ismember(Examples.('radius_mean'), value), :) = []
    
    %If all examples are the same, return the same label
    
    tempLabels = Features(:,end);
    if all(tempLabels(:) == tempLabels(1))
        tree.kids = [];
        tree.prediction = tempLabels(1);
        return
    end
    
    if size(Features,2) <= 1
        return
    end
    
    x = 0;
    xi = 0;
    for i = 1:size(Features, 2) - 1
        xb = InfoGain(Features, i, Features(:,end));
        if xb > x
            xi = i;
            x = xb;
        end
    end
    
    best_attri = xi;
    tree.attribute = best_attri;
    best_thres = best_threshold(Features(:, best_attri),Features(:, end));
    
    LeftSubSet = Features(Features(:,best_attri) < best_thres, :);
    
    size(LeftSubSet)
    
    if ~isempty(LeftSubSet)
        LeftSubSet(:, best_attri) = [];
        
        length(LeftSubSet);
        
        size(LeftSubSet,1);
        tree.kids{1} = ID3_New(LeftSubSet);
    end
    
    RightSubSet = Features(Features(:,best_attri) >= best_thres, :);
    
    if ~isempty(RightSubSet)
        RightSubSet(:, best_attri) = [];
        
        length(RightSubSet);
            
        tree.kids{2} = ID3_New(RightSubSet);
    end
end