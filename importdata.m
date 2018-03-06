function [mag,quat]=importdata(file,row1,row2) %2294:3800
    global q_raw m_raw
    s = csvread(file);
    m = s(row1:row2,6:8);
    q = s(row1:row2,11:14);
        
    m_raw.x = m(:,1);m_raw.y = m(:,2);m_raw.z = m(:,3);
    q_raw.w = q(:,1);q_raw.x = q(:,2);q_raw.y = q(:,3);q_raw.z = q(:,4);
    
    L = length(q_raw.w);
    qx = [];qy = [];qz = [];qw = [];
    mx = [];my = [];mz = []; M = []; Q = [];
    for i=5:L
        if(m_raw.x(i) ~= m_raw.x(i-1) || m_raw.y(i) ~= m_raw.y(i-1) || m_raw.z(i) ~= m_raw.z(i-1) )
            qx = [qx q_raw.x(i)];qy = [qy q_raw.y(i)];qz = [qz q_raw.z(i)];qw = [qw q_raw.w(i)];
            Qc=[q_raw.w(i) q_raw.x(i) q_raw.y(i) q_raw.z(i)];
            Q=[Q ; Qc];
            mx = [mx m_raw.x(i)]; my = [my m_raw.y(i)]; mz = [mz m_raw.z(i)];
            m = [ m_raw.x(i) m_raw.y(i) m_raw.z(i)];
            M = [M;m];
        end
    end
    mag = M;
    quat = Q;
end