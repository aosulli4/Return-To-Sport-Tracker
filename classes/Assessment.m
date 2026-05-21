classdef Assessment

    properties
        Date             % Date of assessment
        HopTest          %Limb symmetry index (%)
        StrengthRatio    % Quad strength ratio (%)
        PainScore        % Self reported pain (0-10)
    end

    properties (Dependent)
        CompositeScore   % Calculated automatically from the three tests
    end

    methods

        %Constructore
        function obj = Assessment( date, hopTest, strengthRatio, painScore)
            obj.Date = date;
            obj.HopTest = hopTest;
            obj.StrengthRatio = strengthRatio;
            obj.PainScore = painScore;
        end


        function score = get.CompositeScore(obj)
            hopNorm = min(obj.HopTest, 100);
            strengthNorm = min(obj.StrengthRatio, 100);
            painNorm = (1 - obj.PainScore/10) * 100;
            score = (hopNorm + strengthNorm + painNorm) / 3;
        end
        % Display method - prints the assessment results neatly
        function displayResults(obj)
            fprintf('\n--- Assessment: %s ---\n', obj.Date)
            fprintf('Hop Test (LSI):      %.1f%%\n', obj.HopTest)
            fprintf('Strength Ratio:      %.1f%%\n', obj.StrengthRatio)
            fprintf('Pain Score:          %.1f/10\n', obj.PainScore)
            fprintf('Composite Score:     %.1f/100\n', obj.CompositeScore)

            % Clearance check for each test
            fprintf('\nClearance criteria:\n')
            if obj.HopTest >= 90
                fprintf('  Hop Test:       PASS ✓\n')
            else
                fprintf('  Hop Test:       FAIL ✗ (need ≥90%%)\n')
            end
            if obj.StrengthRatio >= 90
                fprintf('  Strength Ratio: PASS ✓\n')
            else
                fprintf('  Strength Ratio: FAIL ✗ (need ≥90%%)\n')
            end
            if obj.PainScore <= 2
                fprintf('  Pain Score:     PASS ✓\n')
            else
                fprintf('  Pain Score:     FAIL ✗ (need ≤2/10)\n')
            end
            fprintf('----------------------\n')
        end

    end
end