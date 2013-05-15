//
//  Agent.h
//  hifi
//
//  Created by Stephen Birarda on 2/15/13.
//  Copyright (c) 2013 High Fidelity, Inc. All rights reserved.
//

#ifndef __hifi__Agent__
#define __hifi__Agent__

#include <stdint.h>
#include <ostream>

#ifdef _WIN32
#include "Syssocket.h"
#else
#include <sys/socket.h>
#endif

#include "SimpleMovingAverage.h"
#include "AgentData.h"

class Agent {    
public:
    Agent(sockaddr* publicSocket, sockaddr* localSocket, char type, uint16_t agentID);
    Agent(const Agent &otherAgent);
    ~Agent();
    Agent& operator=(Agent otherAgent);
    bool operator==(const Agent& otherAgent);
    
    bool matches(sockaddr* otherPublicSocket, sockaddr* otherLocalSocket, char otherAgentType);
    
    char getType() const { return _type; }
    void setType(char type) { _type = type; }
    const char* getTypeName() const;
    
    uint16_t getAgentID() const { return _agentID; }
    void setAgentID(uint16_t agentID) { _agentID = agentID;}
    
    double getWakeMicrostamp() const { return _wakeMicrostamp; }
    void setWakeMicrostamp(double wakeMicrostamp) { _wakeMicrostamp = wakeMicrostamp; }
    
    double getLastHeardMicrostamp() const { return _lastHeardMicrostamp; }
    void setLastHeardMicrostamp(double lastHeardMicrostamp) { _lastHeardMicrostamp = lastHeardMicrostamp; }
    
    sockaddr* getPublicSocket() const { return _publicSocket; }
    void setPublicSocket(sockaddr* publicSocket) { _publicSocket = publicSocket; }
    sockaddr* getLocalSocket() const { return _localSocket; }
    void setLocalSocket(sockaddr* localSocket) { _localSocket = localSocket; }
    
    sockaddr* getActiveSocket() const { return _activeSocket; }
    
    void activatePublicSocket();
    void activateLocalSocket();
    
    AgentData* getLinkedData() const { return _linkedData; }
    void setLinkedData(AgentData *linkedData) { _linkedData = linkedData; }
    
    bool isAlive() const { return _isAlive; };
    void setAlive(bool isAlive) { _isAlive = isAlive; };
    
    void  recordBytesReceived(int bytesReceived);
    float getAverageKilobitsPerSecond();
    float getAveragePacketsPerSecond();

    static void printLog(Agent const&);
private:
    void swap(Agent &first, Agent &second);
    
    char _type;
    uint16_t _agentID;
    double _wakeMicrostamp;
    double _lastHeardMicrostamp;
    sockaddr* _publicSocket;
    sockaddr* _localSocket;
    sockaddr* _activeSocket;
    SimpleMovingAverage* _bytesReceivedMovingAverage;
    AgentData* _linkedData;
    bool _isAlive;
};


int unpackAgentId(unsigned char *packedData, uint16_t *agentId);
int packAgentId(unsigned char *packStore, uint16_t agentId);

#endif /* defined(__hifi__Agent__) */
