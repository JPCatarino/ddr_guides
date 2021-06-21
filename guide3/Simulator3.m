function [PL , APD , MPD , TT] = Simulator3(lambda,C,f,P,b)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes)
%  P      - number of packets (stopping criterium)
%  b      - bit error rate
% OUTPUT PARAMETERS:
%  PL   - packet loss (%)
%  APD  - average packet delay (milliseconds)
%  MPD  - maximum packet delay (milliseconds)
%  TT   - transmitted throughput (Mbps)

%Events:
ARRIVAL= 0;       % Arrival of a packet            
DEPARTURE= 1;     % Departure of a packet
TRANSITION = 2;   % the transition of a state in the packet 

%State variables:
STATE = 0;          % 0 - connection free; 1 - connection bysy
QUEUEOCCUPATION= 0; % Occupation of the queue (in Bytes)
QUEUE= [];          % Size and arriving time instant of each packet in the queue
FLOWSTATE = 0;      % Current chain state

%Statistical Counters:
TOTALPACKETS= 0;       % No. of packets arrived to the system
LOSTPACKETS= 0;        % No. of packets dropped due to buffer overflow
TRANSMITTEDPACKETS= 0; % No. of transmitted packets
TRANSMITTEDBYTES= 0;   % Sum of the Bytes of transmitted packets
DELAYS= 0;             % Sum of the delays of transmitted packets
MAXDELAY= 0;           % Maximum delay among all transmitted packets

%Auxiliary variables:
% Initializing the simulation clock:
Clock= 0;

% Calculating the probability of each state
transitions = [10/5 5/10];

% calculo da probabilidade limite de processos de nascimento e morte

sum = transitions(1) + (transitions(2) * transitions(1));

prob_1 = 1/(1+ sum);
prob_2 = prob_1*transitions(1);
prob_3 = prob_2*transitions(2);
probs = [prob_1 prob_2 prob_3];

% Calculo do tempo de permanência

time_1 = (1 / 10);
time_2 = (1 / (5 + 5));
time_3 = (1 / 10);
times = [time_1 time_2 time_3];

% Calculos dos valores de lambda por estado

lambda_values = [0.5*lambda lambda 1.5*lambda];

% Initialize first Transition
FLOWSTATE = CalculateFirstState(probs);
EventList = [TRANSITION, Clock + exprnd(times(FLOWSTATE)), 0, 0];

% Initializing the List of Events with the first ARRIVAL:
EventList = [EventList; ARRIVAL, Clock + exprnd(1/lambda_values(FLOWSTATE)), GeneratePacketSize(), 0];

%Similation loop:
while TRANSMITTEDPACKETS<P               % Stopping criterium
    EventList= sortrows(EventList,2);    % Order EventList by time
    Event= EventList(1,1);               % Get first event and 
    Clock= EventList(1,2);               %   and
    PacketSize= EventList(1,3);          %   associated
    ArrivalInstant= EventList(1,4);      %   parameters.
    EventList(1,:)= [];                  % Eliminate first event
    ProbWithoutErros = CalculateProbabilityOfBER(PacketSize,b);
    switch Event
        case ARRIVAL                     % If first event is an ARRIVAL
            TOTALPACKETS= TOTALPACKETS+1;
            EventList = [EventList; ARRIVAL, Clock + exprnd(1/lambda_values(FLOWSTATE)), GeneratePacketSize(), 0];
            if STATE==0
                STATE= 1;
                EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock];
            else
                if QUEUEOCCUPATION + PacketSize <= f
                    QUEUE= [QUEUE;PacketSize , Clock];
                    QUEUEOCCUPATION= QUEUEOCCUPATION + PacketSize;
                else
                    LOSTPACKETS= LOSTPACKETS + 1;
                end
            end
        case DEPARTURE                     % If first event is a DEPARTURE
            % Verify if has erros; LOSTPACKETS= LOSTPACKETS + 1;
            if rand() > ProbWithoutErros
                LOSTPACKETS= LOSTPACKETS + 1;
            else
                TRANSMITTEDBYTES= TRANSMITTEDBYTES + PacketSize;
                DELAYS= DELAYS + (Clock - ArrivalInstant);

                if Clock - ArrivalInstant > MAXDELAY
                    MAXDELAY= Clock - ArrivalInstant;
                end
                TRANSMITTEDPACKETS= TRANSMITTEDPACKETS + 1; 
            end
                
            if QUEUEOCCUPATION > 0
                EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2)];
                QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                QUEUE(1,:)= [];
            else
                STATE= 0;
            end
        case TRANSITION
            FLOWSTATE = CalculateNextState(FLOWSTATE);
            EventList = [EventList; TRANSITION, Clock + exprnd(times(FLOWSTATE)), 0, 0];
    end
end

%Performance parameters determination:
PL= 100*LOSTPACKETS/TOTALPACKETS;      % in %
APD= 1000*DELAYS/TRANSMITTEDPACKETS;   % in milliseconds
MPD= 1000*MAXDELAY;                    % in milliseconds
TT= 10^(-6)*TRANSMITTEDBYTES*8/Clock;  % in Mbps

end

function out= GeneratePacketSize()
    aux= rand();
    aux2= [65:109 111:1517];
    if aux <= 0.16
        out= 64;
    elseif aux <= 0.16 + 0.25
        out= 110;
    elseif aux <= 0.16 + 0.25 + 0.2
        out= 1518;
    else
        out = aux2(randi(length(aux2)));
    end
end

function result= CalculateProbabilityOfBER(packetSize, ber)
    n = packetSize * 8;
    result = (1-ber)^n;
end

function newState= CalculateNextState(currState)
    next_state_prob = rand();
    
    if currState == 1 || currState == 3
        newState = 2;
    elseif currState == 2
        if next_state_prob < 0.5
            newState = 1;
        else
            newState = 3;
        end
    end    
end

function newState= CalculateFirstState(probs)
    next_state_prob = rand();
    if next_state_prob <= probs(1)
        newState = 1;
    elseif next_state_prob >= 1 - probs(3)
        newState = 3;
    else 
        newState = 2;
    end       
end