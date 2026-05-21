% main.m
% Return-to-Sport Tracker - Demo Script
% Simulates a full ACL rehab journey for one athlete
% ================================================

clear all
clc
addpath('classes')

fprintf('======================================\n')
fprintf(' RETURN TO SPORT TRACKER - DEMO\n')
fprintf('======================================\n\n')

% --- Create an athlete ---
sarah = Athlete('Sarah Jones', 22, 'Football', 'ACL tear', '2024-11-01');

% --- Create her tracker ---
tracker = RTSTracker(sarah);

% --- Simulate assessments over her rehab journey ---
% Month 2 - early rehab, scores are low
a1 = Assessment('2025-01-01', 62, 65, 6);
tracker.addAssessment(a1);

% Month 4 - improving
a2 = Assessment('2025-03-01', 74, 78, 4);
tracker.addAssessment(a2);

% Month 6 - good progress
a3 = Assessment('2025-05-01', 84, 86, 3);
tracker.addAssessment(a3);

% Month 8 - nearly there
a4 = Assessment('2025-07-01', 88, 89, 2);
tracker.addAssessment(a4);

% Month 9 - ready!
a5 = Assessment('2025-08-01', 93, 92, 1);
tracker.addAssessment(a5);

% --- Print full summary ---
tracker.printSummary()

% --- Plot progress graphs ---
tracker.plotProgress()

% --- Final clearance decision ---
tracker.makeDecision()