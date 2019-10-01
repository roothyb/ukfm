f = @(x) squeeze(mean(x, 3));
ukf_nees = f(ukf_nees);
left_ukf_nees = f(left_ukf_nees);
right_ukf_nees = f(right_ukf_nees);
iekf_nees = f(iekf_nees);
ekf_nees = f(ekf_nees);

fig4 = figure;
set(gca, 'YScale', 'log')
title('Robot orientation NEES')
xlabel('$t$ (s)')
ylabel('orientation NEES')
hold on;
grid on;
plot(t, ukf_nees(1, :), 'm');
plot(t, left_ukf_nees(1, :), 'g');
plot(t, right_ukf_nees(1, :), 'c');
plot(t, ekf_nees(1, :), 'r');
plot(t, iekf_nees(1, :), 'b');
legend('$SO(2)$ UKF', '$SE(2)$ \textbf{left UKF}', ...
    '$SE(2)$ \textbf{right UKF}', 'EKF', 'IEKF [BB17]');

fig5 = figure;
set(gca, 'YScale', 'log')
title('Robot position NEES')
xlabel('$t$ (s)')
ylabel('position NEES')
hold on;
grid on;
plot(t, ukf_nees(1, :), 'm');
plot(t, left_ukf_nees(1, :), 'g');
plot(t, right_ukf_nees(1, :), 'c');
plot(t, ekf_nees(1, :), 'r');
plot(t, iekf_nees(1, :), 'b');
legend('$SO(2)$ UKF', '$SE_{1+L}(2)$ \textbf{left UKF}', ...
    '$SE_{1+L}(2)$ \textbf{right UKF}', 'EKF', 'IEKF [BB17]');

f_rot = @(x) sprintf('%0.2f', mean(x(1, :)));
f_p = @(x) sprintf('%0.2f', mean(x(2, :)));

ukf_nees_Rot = f_rot(ukf_nees);
ukf_nees_p = f_p(ukf_nees);
left_ukf_nees_Rot = f_rot(left_ukf_nees);
left_ukf_nees_p = f_p(left_ukf_nees);
right_ukf_nees_Rot = f_rot(right_ukf_nees);
right_ukf_nees_p = f_p(right_ukf_nees);
ekf_nees_Rot = f_rot(ekf_nees);
ekf_nees_p = f_p(ekf_nees);
iekf_nees_Rot = f_rot(iekf_nees);
iekf_nees_p = f_p(iekf_nees);

if cur_folder == "matlab"
    print(fig4, 'benchmarks/html/figures/benchmark_slam2d_04', ...
        '-dpng', '-r600')
    print(fig5, 'benchmarks/html/figures/benchmark_slam2d_05', ...
        '-dpng', '-r600')
end
disp(' ')
disp('Normalized Estimation Error Squared (NEES) w.r.t. orientation');
disp("    -SO(2) x R^{2(1+L)} UKF: " + ukf_nees_Rot);
disp("    -left SE_{1+L}(2) UKF  : " + left_ukf_nees_Rot);
disp("    -right SE_{1+L}(2) UKF : " + right_ukf_nees_Rot);
disp("    -EKF                   : " + ekf_nees_Rot);
disp("    -IEKF                  : " + iekf_nees_Rot);

disp(' ')
disp('Normalized Estimation Error Squared (NEES) w.r.t. position')
disp("    -SO(2) x R^{2(1+L)} UKF: " + ukf_nees_p);
disp("    -left SE_{1+L}(2) UKF  : " + left_ukf_nees_p);
disp("    -right SE_{1+L}(2) UKF : " + right_ukf_nees_p);
disp("    -EKF                   : " + ekf_nees_p);
disp("    -IEKF                  : " + iekf_nees_p);