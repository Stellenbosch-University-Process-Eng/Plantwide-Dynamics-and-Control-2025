function ySS = SteadyState(CV_fields)
    out = sim('MillingCircuit_RGA.slx');
    for field = CV_fields
        y = out.(field);
        ySS.(field) = y(end);
    end
end