function enorm = normalize_errors(e)
enorm = (e-min(e)) / (max(e)-min(e));
