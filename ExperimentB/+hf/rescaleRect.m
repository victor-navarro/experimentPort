function rect = rescaleRect(rect, rectRange, newRange)
    %helper function to rescale psychtoolbox rects
    %rect is a vector with the rect coordinates (i.e., [x1, y1, x2, y2])
    %rectRange is the range for rect (e.g., [0, 0, 1, 1], if your rect is in unit space)
    %newRange is the new range (e.g., [0, 0, 1024, 768]; usually your
    %display area or a portion of it.
    rect([1, 3]) = hf.rescale(rect([1, 3]), rectRange([1, 3]), newRange([1, 3]));
    rect([2, 4]) = hf.rescale(rect([2, 4]), rectRange([2, 4]), newRange([2, 4]));