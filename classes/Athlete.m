classdef Athlete

    properties 
        Name
        Age
        Sport
        Injury
        InjuryDate
    end

    methods

        % The Constructor Method
        function obj = Athlete(name, age, sport, injury, injuryDate)
            obj.Name = name; % This specific object's name
            obj.Age = age;
            obj.Sport = sport;
            obj.Injury = injury;
            obj.InjuryDate = injuryDate;
        end 

        function displayInfo(obj)
            fprintf('--- Athlete Profile ---\n')
            fprintf('Name:         %s\n', obj.Name)
            fprintf('Age:          %d\n', obj.Age)
            fprintf('Sport:        %s\n', obj.Sport)
            fprintf('Injury:       %s\n', obj.Injury)
            fprintf('Injury Date:  %s\n', obj.InjuryDate)
            fprintf('-----------------------\n')
        end
    end
end
