function feature_vector = find_features(data_sample)
    % Construct the feature vector in both time domain and frequency domain
    feature_vector_time = find_time_features(data_sample);
    feature_vector_fre = find_frequency_features(data_sample);
    feature_vector = [feature_vector_time;feature_vector_fre];
end