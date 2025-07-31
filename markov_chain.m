function markov_chain_ngram_gui()
    f = figure('Name','Word-Level Markov Chain LLM','Position',[300 100 900 600]);
    uicontrol('Style','text','String','Input Text:',...
        'Position',[20 560 100 20],'HorizontalAlignment','left');
    inputBox = uicontrol('Style','edit','Max',2,'Min',0,...
        'Position',[20 300 400 260],'HorizontalAlignment','left','FontName','Courier','FontSize',10);
    uicontrol('Style','text','String','Generated Text:',...
        'Position',[480 560 120 20],'HorizontalAlignment','left');
    outputBox = uicontrol('Style','edit','Max',2,'Min',0,...
        'Position',[480 300 400 260],'HorizontalAlignment','left','FontName','Courier','FontSize',10);
    uicontrol('Style','text','String','N-gram size:',...
        'Position',[20 250 100 20],'HorizontalAlignment','left');
    ngramBox = uicontrol('Style','edit','String','3',...
        'Position',[120 250 50 25]);
    uicontrol('Style','text','String','Generate Length (words):',...
        'Position',[20 220 140 20],'HorizontalAlignment','left');
    lengthBox = uicontrol('Style','edit','String','100',...
        'Position',[160 220 50 25]);
    uicontrol('Style','pushbutton','String','Process Text',...
        'Position',[20 180 150 30],'Callback',@processText);
    uicontrol('Style','pushbutton','String','Generate Text',...
        'Position',[190 180 150 30],'Callback',@generateText);
    matrixBox = uicontrol('Style','text','String','Status: Waiting for input...', ...
        'Position',[20 150 860 20],'HorizontalAlignment','left');
    model = struct();

    function processText(~,~)
        raw = get(inputBox, 'String');
        
        % Handle multiline text from uicontrol (comes as char matrix)
        if iscell(raw)
            raw = strjoin(raw, newline);
        elseif ischar(raw) && size(raw, 1) > 1
            % Convert char matrix to single row vector
            raw = raw'; % transpose
            raw = raw(:)'; % flatten to row vector
        end
        
        % Ensure it's a char row vector
        raw = char(raw);
        raw = lower(raw);
        
        n = str2double(get(ngramBox, 'String'));
        if isnan(n) || n < 1
            errordlg('Invalid n-gram size.');
            return;
        end
        
        words = extractWords(raw);
        if length(words) < n + 1
            errordlg('Need more text for this n-gram size.');
            return;
        end
        
        [transitions, starters] = buildWordMarkovModel(words, n);
        model.transitions = transitions;
        model.starters = starters;
        model.n = n;
        
        matrixBox.String = sprintf('Processed %d words. Unique %d-grams: %d.', ...
            length(words), n, transitions.Count);
    end

    function generateText(~,~)
        if ~isfield(model, 'transitions')
            errordlg('Please process text first.');
            return;
        end
        
        len = str2double(lengthBox.String);
        if isnan(len) || len < model.n
            errordlg('Invalid generation length.');
            return;
        end
        
        txt = generateWordSequence(model.transitions, model.starters, model.n, len);
        outputBox.String = txt;
    end
end

function words = extractWords(text)
    % Split text into words, preserving punctuation as separate tokens
    % text should already be a char array at this point
    
    % Add spaces around punctuation to separate them
    text = regexprep(text, '([.!?,:;"])', ' $1 ');
    
    % Split on whitespace and filter out empty strings
    words = strsplit(text);
    words = words(~cellfun('isempty', words));
    
    % Convert to string array
    words = string(words);
end

function [transitions, starters] = buildWordMarkovModel(words, n)
    transitions = containers.Map('KeyType', 'char', 'ValueType', 'any');
    starters = {};
    
    for i = 1:(length(words) - n)
        % Create n-gram key
        ngram = words(i:i+n-1);
        key = strjoin(ngram, ' ');
        next_word = words(i+n);
        
        % Store starter n-grams (beginning of sentences or after periods)
        if i == 1 || any(words(i-1) == [".", "!", "?"])
            starters{end+1} = char(key);
        end
        
        % Build transition map
        if ~isKey(transitions, char(key))
            transitions(char(key)) = string.empty;
        end
        
        currentList = transitions(char(key));
        transitions(char(key)) = [currentList, next_word];
    end
    
    % If no sentence starters found, use the first n-gram
    if isempty(starters)
        first_ngram = words(1:n);
        starters{1} = char(strjoin(first_ngram, ' '));
    end
end

function out = generateWordSequence(transitions, starters, n, maxWords)
    % Pick a random starting n-gram
    current_key = starters{randi(length(starters))};
    current_words = strsplit(current_key);
    
    result_words = string(current_words);
    
    while length(result_words) < maxWords
        if isKey(transitions, current_key)
            options = transitions(current_key);
            if ~isempty(options)
                next_word = options(randi(length(options)));
                result_words(end+1) = next_word;
                
                % Update current n-gram (slide the window)
                if length(result_words) >= n
                    current_words = result_words(end-n+1:end);
                    current_key = char(strjoin(current_words, ' '));
                end
            else
                break;
            end
        else
            break;
        end
    end
    
    % Join words back into text
    out = char(strjoin(result_words, ' '));
    
    % Clean up spacing around punctuation
    out = regexprep(out, ' +([.!?,:;"])', '$1');
    out = regexprep(out, '  +', ' ');
end