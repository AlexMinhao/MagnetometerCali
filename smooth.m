function [M_raw,k] = smooth(m_raw)
    m = [];
    for k = 1:length(m_raw)
        index =  randperm(length(m_raw),1);
        v0 = m_raw(k,:);
        %d = [];

%         for i = 1:length(m_raw)
%            d_0 = sqrt((m_raw(i,1)-v0(1)).^2 + (m_raw(i,2)-v0(2)).^2+(m_raw(i,3)-v0(3)).^2); 
%            d = [d d_0];
%         end
        
        idx = knnsearch(m_raw,v0,'k',4);
 
%         JL_data = [m_raw(:,1) m_raw(:,2) m_raw(:,3) d'];
%         [u,v]=sort(JL_data(:,4));
        v1 = m_raw(idx(2),:);
        v2 = m_raw(idx(3),:);
        v3 = m_raw(idx(4),:);
        %m = [v1;v2;v3];
    if(norm(v1-v2)~= 0 &&  norm(v1-v3)~= 0 && norm(v2-v3)~= 0)
        a1 = v1-v2;
        a2 = v3-v2;
        Normal = cross(a1,a2);
        direction = v0/norm(v0);
        %（L0 + dL - P0）· normal = 0；--->   dL · normal + (L0 - P0) · normal = 0;
     if(k==500)
         a=1;
     end
        syms dis;
        equ = dot((v0+direction*[dis 0 0;0 dis 0; 0 0 dis] - v2),Normal); 
        distance = solve(equ,dis);
        delt = double(distance);
        v5 = delt*direction+v0; % 与平面交点
        
        % Compute vectors
       
        A = v3 - v1;
        B = v2 - v1;
        C = v5 - v1;
       disp(A);

        % Compute dot products
        try
        dot00 = dot(A, A);
        dot01 = dot(A, B);
        dot02 = dot(A, C);
        dot11 = dot(B, B);
        dot12 = dot(B, C);
         catch 
            disp(A);
            disp(B);
            disp(C);
        end
        % Compute barycentric coordinates
        invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
        u = (dot11 * dot02 - dot01 * dot12) * invDenom;
        v = (dot00 * dot12 - dot01 * dot02) * invDenom;

        % Check if point is in triangle
        if u > 0 && v > 0 && u + v < 1
            flag = 1;
            m_raw(k,:)= v5;
        elseif u == 0 || v == 0 || u + v == 1
            flag = 0;
            m_raw(k,:)=v5;
        else
            flag = -1;
        end
    end
    end
    M_raw = m_raw;
end