classdef RTSTracker < handle

    properties
        Athlete
        Assessments
    end

    methods 

        function obj = RTSTracker(athlete)
            obj.Athlete = athlete;
            obj.Assessments = Assessment.empty(0,1);
        end


        function addAssessment(obj, assessment)
            obj.Assessments(end+1) = assessment;
            fprintf("Assessment added for %s on %s|n", ...
                obj.Athlete.Name, assessment.Date)
        end

        function printSummary(obj)
            fprintf('\n=============================\n')
            fprintf(' RTS TRACKER: %s\n', obj.Athlete.Name)
            fprintf('=============================\n')
            obj.Athlete.displayInfo()
            fprintf('\nTotal assessments: %d\n', length(obj.Assessments))
            for i = 1:length(obj.Assessments)
                obj.Assessments(i).displayResults()
            end
        end
        % Plot progress over all assessments
        function plotProgress(obj)
            n = length(obj.Assessments);
            if n == 0
                fprintf('No assessments to plot yet.\n')
                return
            end

            % Pull out scores from each assessment
            hopScores      = zeros(1,n);
            strengthScores = zeros(1,n);
            painScores     = zeros(1,n);
            composite      = zeros(1,n);
            dates          = cell(1,n);

            for i = 1:n
                hopScores(i)      = obj.Assessments(i).HopTest;
                strengthScores(i) = obj.Assessments(i).StrengthRatio;
                painScores(i)     = obj.Assessments(i).PainScore;
                composite(i)      = obj.Assessments(i).CompositeScore;
                dates{i}          = obj.Assessments(i).Date;
            end

            % Plot
            figure('Name', 'RTS Progress', 'NumberTitle', 'off')

            subplot(2,2,1)
            plot(1:n, hopScores, 'bo-', 'LineWidth', 2)
            yline(90, 'r--', 'Clearance (90%)')
            title('Hop Test (LSI %)')
            xlabel('Assessment'), ylabel('%')
            xticks(1:n), xticklabels(dates)
            ylim([0 100]), grid on

            subplot(2,2,2)
            plot(1:n, strengthScores, 'go-', 'LineWidth', 2)
            yline(90, 'r--', 'Clearance (90%)')
            title('Strength Ratio (%)')
            xlabel('Assessment'), ylabel('%')
            xticks(1:n), xticklabels(dates)
            ylim([0 100]), grid on

            subplot(2,2,3)
            plot(1:n, painScores, 'ro-', 'LineWidth', 2)
            yline(2, 'r--', 'Clearance (≤2)')
            title('Pain Score (/10)')
            xlabel('Assessment'), ylabel('Pain')
            xticks(1:n), xticklabels(dates)
            ylim([0 10]), grid on

            subplot(2,2,4)
            plot(1:n, composite, 'mo-', 'LineWidth', 2)
            yline(90, 'r--', 'Target (90)')
            title('Composite Score (/100)')
            xlabel('Assessment'), ylabel('Score')
            xticks(1:n), xticklabels(dates)
            ylim([0 100]), grid on

            sgtitle(['Rehab Progress — ' obj.Athlete.Name])
        end

        % Final clearance decision based on most recent assessment
        function makeDecision(obj)
            if isempty(obj.Assessments)
                fprintf('No assessments recorded yet.\n')
                return
            end

            latest = obj.Assessments(end);
            hopPass      = latest.HopTest      >= 90;
            strengthPass = latest.StrengthRatio >= 90;
            painPass     = latest.PainScore     <= 2;

            fprintf('\n=============================\n')
            fprintf(' CLEARANCE DECISION\n')
            fprintf(' Athlete: %s\n', obj.Athlete.Name)
            fprintf(' Based on assessment: %s\n', latest.Date)
            fprintf('=============================\n')

            if hopPass && strengthPass && painPass
                fprintf(' ✓ CLEARED FOR RETURN TO SPORT\n')
            else
                fprintf(' ✗ NOT YET CLEARED\n')
                fprintf(' Criteria not met:\n')
                if ~hopPass
                    fprintf('   - Hop Test: %.1f%% (need ≥90%%)\n', latest.HopTest)
                end
                if ~strengthPass
                    fprintf('   - Strength: %.1f%% (need ≥90%%)\n', latest.StrengthRatio)
                end
                if ~painPass
                    fprintf('   - Pain: %.1f/10 (need ≤2)\n', latest.PainScore)
                end
            end
            fprintf('=============================\n')
        end

    end
end