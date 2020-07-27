declare namespace MyAvatar {
	// variables
	var position: Vec3;
	var scale: number;
	var density: number;
	var handPosition: Vec3;
	var bodyYaw: number;
	var bodyPitch: number;
	var bodyRoll: number;
	var orientation: Quat;
	var headOrientation: Quat;
	var headPitch: number;
	var headYaw: number;
	var headRoll: number;
	var velocity: Vec3;
	var angularVelocity: Vec3;
	var audioLoudness: number;
	var audioAverageLoudness: number;
	var displayName: string;
	var sessionDisplayName: string;
	var lookAtSnappingEnabled: boolean;
	var skeletonModelURL: string;
	var attachmentData: AttachmentData[];
	var jointNames: string[];
	var sessionUUID: Uuid;
	var sensorToWorldMatrix: Mat4;
	var controllerLeftHandMatrix: Mat4;
	var controllerRightHandMatrix: Mat4;
	var sensorToWorldScale: number;
	var hasPriority: boolean;
	var skeletonOffset: Vec3;
	var qmlPosition: Vec3;
	var feetPosition: Vec3;
	var shouldRenderLocally: boolean;
	var motorVelocity: Vec3;
	var motorTimescale: number;
	var motorReferenceFrame: string;
	var motorMode: string;
	var collisionSoundURL: string;
	var audioListenerMode: number;
	var audioListenerModeHead: number;
	var audioListenerModeCamera: number;
	var audioListenerModeCustom: number;
	var customListenPosition: Vec3;
	var customListenOrientation: Quat;
	var hasScriptedBlendshapes: boolean;
	var hasProceduralBlinkFaceMovement: boolean;
	var hasProceduralEyeFaceMovement: boolean;
	var hasAudioEnabledFaceMovement: boolean;
	var rotationRecenterFilterLength: number;
	var rotationThreshold: number;
	var enableStepResetRotation: boolean;
	var enableDrawAverageFacing: boolean;
	var leftHandPosition: Vec3;
	var rightHandPosition: Vec3;
	var leftHandTipPosition: Vec3;
	var rightHandTipPosition: Vec3;
	var leftHandPose: Pose;
	var rightHandPose: Pose;
	var leftHandTipPose: Pose;
	var rightHandTipPose: Pose;
	var isAway: boolean;
	var centerOfGravityModelEnabled: boolean;
	var hmdLeanRecenterEnabled: boolean;
	var collisionsEnabled: boolean;
	var otherAvatarsCollisionsEnabled: boolean;
	var characterControllerEnabled: boolean;
	var useAdvancedMovementControls: boolean;
	var showPlayArea: boolean;
	var yawSpeed: number;
	var pitchSpeed: number;
	var hmdRollControlEnabled: boolean;
	var hmdRollControlDeadZone: number;
	var hmdRollControlRate: number;
	var userHeight: number;
	var userEyeHeight: number;
	var SELF_ID: Uuid;
	var walkSpeed: number;
	var walkBackwardSpeed: number;
	var sprintSpeed: number;
	var analogPlusWalkSpeed: number;
	var analogPlusSprintSpeed: number;
	var userRecenterModel: number;
	var isInSittingState: number;
	var isSitStandStateLocked: boolean;
	var allowTeleporting: boolean;

	// methods
	function getDefaultFullAvatarURL(): string;
	function getFullAvatarModelName(): string;
	function getFullAvatarURLFromPreferences(): string;
	function randomizeDefaultAvatar(): void;
	function setCollisionsEnabled(enabled: boolean): void;
	function setOtherAvatarsCollisionsEnabled(enabled: boolean): void;
	function useFullAvatarURL(modelURL: string, name: string): void;

	enum SitStandModelType {
		ForceSit,
		ForceStand,
		Auto,
		DisableHMDLean,
	}

	// signals
	const collisionsEnabledChanged: Signal<(enabled: boolean) => any>;
	const displayNameChanged: Signal<() => any>;
	const otherAvatarsCollisionsEnabledChanged: Signal<(
		enabled: boolean,
	) => any>;
	const sessionUUIDChanged: Signal<() => any>;
	const skeletonModelURLChanged: Signal<() => any>;
}
