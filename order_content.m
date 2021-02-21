


function [new_data] = order_content(file_name,data,header,channels,seizures)
    samples = header.records*header.samplerate(1);
    data_z = zeros(length(channels),samples);
    for j=1:length(channels)
        for k=1:header.channels
            if cell2mat(header.labels(k)) == channels(j)
                signal = data(k);
                data_z(j,:)= signal{:}; 
                break
            end
        end 
    end
    seizure = [];
    for i=1:length(seizures)
       if file_name == seizures(i).filename
          seizure = seizures(i);
          break
       end
    end
    new_data.ch = channels;
    new_data.signals = data_z;
    new_data.samples = samples;
    new_data.srate = header.samplerate(1);
    new_data.ch_num = length(channels);
    new_data.seizures = seizure;
end