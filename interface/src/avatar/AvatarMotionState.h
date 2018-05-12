//
//  AvatarMotionState.h
//  interface/src/avatar/
//
//  Created by Andrew Meadows 2015.05.14
//  Copyright 2015 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//

#ifndef hifi_AvatarMotionState_h
#define hifi_AvatarMotionState_h

#include <QSet>

#include <avatars-renderer/Avatar.h>
#include <ObjectMotionState.h>
#include <BulletUtil.h>


class AvatarMotionState : public ObjectMotionState {
public:
    AvatarMotionState(AvatarSharedPointer avatar, const btCollisionShape* shape);

    void handleEasyChanges(uint32_t& flags) override;
    bool handleHardAndEasyChanges(uint32_t& flags, PhysicsEngine* engine) override;

    PhysicsMotionType getMotionType() const override { return _motionType; }

    uint32_t getIncomingDirtyFlags() override;
    void clearIncomingDirtyFlags() override;

    PhysicsMotionType computePhysicsMotionType() const override;

    bool isMoving() const override;

    // this relays incoming position/rotation to the RigidBody
    void getWorldTransform(btTransform& worldTrans) const override;

    // this relays outgoing position/rotation to the EntityItem
    void setWorldTransform(const btTransform& worldTrans) override;


    // These pure virtual methods must be implemented for each MotionState type
    // and make it possible to implement more complicated methods in this base class.

    // pure virtual overrides from ObjectMotionState
    float getObjectRestitution() const override;
    float getObjectFriction() const override;
    float getObjectLinearDamping() const override;
    float getObjectAngularDamping() const override;

    glm::vec3 getObjectPosition() const override;
    glm::quat getObjectRotation() const override;
    glm::vec3 getObjectLinearVelocity() const override;
    glm::vec3 getObjectAngularVelocity() const override;
    glm::vec3 getObjectGravity() const override;

    const QUuid getObjectID() const override;

    QUuid getSimulatorID() const override;

    void setBoundingBox(const glm::vec3& corner, const glm::vec3& diagonal);

    void addDirtyFlags(uint32_t flags) { _dirtyFlags |= flags; }

    void computeCollisionGroupAndMask(int16_t& group, int16_t& mask) const override;

    float getMass() const override;

    friend class AvatarManager;
    friend class Avatar;

protected:
    // the dtor had been made protected to force the compiler to verify that it is only
    // ever called by the Avatar class dtor.
    ~AvatarMotionState();

    bool isReadyToComputeShape() const override { return true; }
    const btCollisionShape* computeNewShape() override;

    AvatarSharedPointer _avatar;
    float _radius2 { 0.0f };

    uint32_t _dirtyFlags;
};

#endif // hifi_AvatarMotionState_h
