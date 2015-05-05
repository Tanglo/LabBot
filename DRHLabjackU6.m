//
//  DRHLabjackU6.m
//  LabBot
//
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHLabjackU6.h"
#import "u6.h"

NSString * const DRHLabJackU6ConfigScanRateKey = @"DRHLJU6ScanRateKey";
NSString * const DRHLabJackU6ConfigNumAnalogueChanKey = @"DRHLJU6NumberAnalogueChannelsKey";
NSString * const DRHLabJackU6ConfigSamplesPerPacketKey = @"DRHLJU6SamplesPerPacketKey";

@implementation DRHLabjackU6 {
    //The LabJack U6 device's handle.  Details by LabJack in u6.h file.
    HANDLE handle;
    //A structure for storing calibration constants.  Details by LabJack in u6.h file.
    u6CalibrationInfo caliInfo;
}

#pragma mark Initialisers
-(DRHLabjackU6 *)initWithSerialNum:(int)serialNum{
    if (self = [super init]) {
        handle = NULL;
        if( (handle = openUSBConnection(serialNum)) != NULL ){
            if (getCalibrationInfo(handle, &caliInfo) < 0)
                return nil;
            numAnalogueChan = 0;
            samplesPerPacket = 0;
            scanRate = 0;
            return self;
        }
    }
    return nil;
}

+(DRHLabjackU6 *)u6WithSerialNum:(int)serialNum{
    return [[self alloc] initWithSerialNum:serialNum];
}

-(DRHLabjackU6 *)initForStreamingWithSerialNum:(int)serialNum AndSettings:(NSDictionary *)settings{
    if (self = [self initWithSerialNum:serialNum]) {
/*        handle = newHandle;
        if (getCalibrationInfo(handle, &caliInfo) < 0)
            return nil;*/
        
        numAnalogueChan = [[settings objectForKey:DRHLabJackU6ConfigNumAnalogueChanKey] integerValue]; //5;
        samplesPerPacket = [[settings objectForKey:DRHLabJackU6ConfigSamplesPerPacketKey] integerValue]; //25;
        scanRate = [[settings objectForKey:DRHLabJackU6ConfigScanRateKey] integerValue];
    }
    return self;
}

+(DRHLabjackU6 *)u6ForStreamingWithSerialNum:(int)serialNum AndSettings:(NSDictionary *)settings{
    return [[self alloc] initForStreamingWithSerialNum:serialNum AndSettings:settings];
}

#pragma mark Getters
-(HANDLE)handle{
    return handle;
}

#pragma mark Sampling
-(NSNumber *)readOneSampleFromAnalogueChannel:(uint8)channel{
    long count;
    uint8 sendBuff[12], recBuff[12];
    unsigned long sendChars, recChars;
    uint16 checksumTotal;
    double voltage; //, temperature;
    
    sendBuff[1] = (uint8)(0xF8);  //Command byte
    sendBuff[2] = 3;             //Number of data words (.5 word for echo, 2 words for sample and 0.5 words of padding)
    sendBuff[3] = (uint8)(0x00);  //Extended command number
    
    sendBuff[6] = 0;  //Echo
    
    sendBuff[7] = 2;         //IOType is AIN24
    sendBuff[8] = channel;  //0;         //Positive channel
    sendBuff[9] = 8 + 0*16;  //ResolutionIndex(Bits 0-3) = 8,
    //GainIndex(Bits 4-7) = 0 (+-10V)
    
    sendBuff[10] =  0 + 0*128;  //SettlingFactor(Bits 0-2) = 0 (5 microseconds),
    // Differential(Bit 7) = 0
    
    sendBuff[11] = 0;    //Padding byte
    
    extendedChecksum(sendBuff, 12);
    
    count = 0;
        //Sending command to U6
    if( (sendChars = LJUSB_Write(handle, sendBuff, 12)) < 12 )
    {
        if(sendChars == 0)
            printf("Feedback loop error : write failed\n");
        else
            printf("Feedback loop error : did not write all of the buffer\n");
        return nil;
    }
    
    //Reading response from U6
    if( (recChars = LJUSB_Read(handle, recBuff, 12)) < 12 )
    {
        if( recChars == 0 )
        {
            printf("Feedback loop error : read failed\n");
            return nil;
        }
        else
            printf("Feedback loop error : did not read all of the expected buffer\n");
    }
    
    if( recChars < 10 )
    {
        printf("Feedback loop error : response is not large enough\n");
        return nil;
    }
    
    checksumTotal = extendedChecksum16(recBuff, (int)recChars);
    if( (uint8)((checksumTotal / 256 ) & 0xff) != recBuff[5] )
    {
        printf("Feedback loop error : read buffer has bad checksum16(MSB)\n");
        return nil;
    }
    
    if( (uint8)(checksumTotal & 0xff) != recBuff[4] )
    {
        printf("Feedback loop error : read buffer has bad checksum16(LBS)\n");
        return nil;
    }
    
    if( extendedChecksum8(recBuff) != recBuff[0] )
    {
        printf("Feedback loop error : read buffer has bad checksum8\n");
        return nil;
    }
    
    if( recBuff[1] != (uint8)(0xF8) ||  recBuff[3] != (uint8)(0x00) )
    {
        printf("Feedback loop error : read buffer has wrong command bytes \n");
        return nil;
    }
        
    getAinVoltCalibrated(&(caliInfo), 8, 0, 1, recBuff[9] + recBuff[10]*256 + recBuff[11]*65536, &voltage);
    
    return [NSNumber numberWithDouble:voltage];
}

+(NSNumber *)readOneSampleFromAnalogueChannel:(uint8)channel AndDeviceWithSerialNum:(int)serialNum{
    DRHLabjackU6 *labJack = [DRHLabjackU6 u6WithSerialNum:serialNum];
    NSNumber *sample = [labJack readOneSampleFromAnalogueChannel:channel];
    closeUSBConnection([labJack handle]);
    return sample;
}

-(BOOL)configureStream{
    int sendBuffSize;
    sendBuffSize = 14+(int)numAnalogueChan*2;
    uint8 sendBuff[sendBuffSize], recBuff[8];
    unsigned long sendChars, recChars;
    uint16 checksumTotal;
    uint16 scanInterval;
    int i;
    
    sendBuff[1] = (uint8)(0xF8);     //Command byte
    sendBuff[2] = 4 + numAnalogueChan;   //Number of data words = NumChannels + 4
    sendBuff[3] = (uint8)(0x11);     //Extended command number
    sendBuff[6] = numAnalogueChan;       //NumChannels
    sendBuff[7] = 1;                 //ResolutionIndex
    sendBuff[8] = samplesPerPacket;  //SamplesPerPacket
    sendBuff[9] = 0;                 //Reserved
    sendBuff[10] = 0;                //SettlingFactor: 0
    sendBuff[11] = 0;  //ScanConfig:
    //  Bit 3: Internal stream clock frequency = b0: 4 MHz
    //  Bit 1: Divide Clock by 256 = b0
    
    scanInterval = 4000000 / scanRate;  //scanRate;
    sendBuff[12] = (uint8)(scanInterval&(0x00FF));  //scan interval (low byte)
    sendBuff[13] = (uint8)(scanInterval/256);       //scan interval (high byte)
    
    for( i = 0; i < numAnalogueChan; i++ )
    {
        sendBuff[14 + i*2] = i;  //ChannelNumber (Positive) = i
        sendBuff[15 + i*2] = 0;  //ChannelOptions:
        //  Bit 7: Differential = 0
        //  Bit 5-4: GainIndex = 0 (+-10V)
    }
    
    extendedChecksum(sendBuff, sendBuffSize);
    
    //Sending command to U6
    sendChars = LJUSB_Write(handle, sendBuff, sendBuffSize);
    if( sendChars < sendBuffSize )
    {
        if( sendChars == 0 )
            printf("Error : write failed (StreamConfig).\n");
        else
            printf("Error : did not write all of the buffer (StreamConfig).\n");
        return NO;
    }
    
    for( i = 0; i < 8; i++ )
        recBuff[i] = 0;
    
    //Reading response from U6
    recChars = LJUSB_Read(handle, recBuff, 8);
    if( recChars < 8 )
    {
        if( recChars == 0 )
            printf("Error : read failed (StreamConfig).\n");
        else
            printf("Error : did not read all of the buffer, %lu (StreamConfig).\n", recChars);
        
        for( i = 0; i < 8; i++)
            printf("%d ", recBuff[i]);
        
        return NO;
    }
    
    checksumTotal = extendedChecksum16(recBuff, 8);
    if( (uint8)((checksumTotal / 256) & 0xff) != recBuff[5])
    {
        printf("Error : read buffer has bad checksum16(MSB) (StreamConfig).\n");
        return NO;
    }
    
    if( (uint8)(checksumTotal & 0xff) != recBuff[4] )
    {
        printf("Error : read buffer has bad checksum16(LSB) (StreamConfig).\n");
        return NO;
    }
    
    if( extendedChecksum8(recBuff) != recBuff[0] )
    {
        printf("Error : read buffer has bad checksum8 (StreamConfig).\n");
        return NO;
    }
    
    if( recBuff[1] != (uint8)(0xF8) || recBuff[2] != (uint8)(0x01) || recBuff[3] != (uint8)(0x11) || recBuff[7] != (uint8)(0x00) )
    {
        printf("Error : read buffer has wrong command bytes (StreamConfig).\n");
        return NO;
    }
    
    if( recBuff[6] != 0 )
    {
        printf("Errorcode # %d from StreamConfig read.\n", (unsigned int)recBuff[6]);
        return NO;
    }
    
    return YES;
}

-(BOOL)startStream{
    uint8 sendBuff[2], recBuff[4];
    unsigned long sendChars, recChars;
    
    sendBuff[0] = (uint8)(0xA8);  //Checksum8
    sendBuff[1] = (uint8)(0xA8);  //Command byte
    
    //Sending command to U6
    sendChars = LJUSB_Write(handle, sendBuff, 2);
    if( sendChars < 2 )
    {
        if( sendChars == 0 )
            printf("Error : write failed (StreamStart).\n");
        else
            printf("Error : did not write all of the buffer.\n");
        return NO;
    }
    
    //Reading response from U6
    recChars = LJUSB_Read(handle, recBuff, 4);
    if( recChars < 4 )
    {
        if( recChars == 0 )
            printf("Error : read failed.\n");
        else
            printf("Error : did not read all of the buffer.\n");
        return NO;
    }
    
    if( normalChecksum8(recBuff, 4) != recBuff[0] )
    {
        printf("Error : read buffer has bad checksum8 (StreamStart).\n");
        return NO;
    }
    
    if( recBuff[1] != (uint8)(0xA9) || recBuff[3] != (uint8)(0x00) )
    {
        printf("Error : read buffer has wrong command bytes \n");
        return NO;
    }
    
    if( recBuff[2] != 0 )
    {
        printf("Errorcode # %d from StreamStart read.\n", (unsigned int)recBuff[2]);
        return NO;
    }
    
    return YES;
}

-(BOOL)stopStream{
    uint8 sendBuff[2], recBuff[4];
    unsigned long sendChars, recChars;
    
    sendBuff[0] = (uint8)(0xB0);  //Checksum8
    sendBuff[1] = (uint8)(0xB0);  //Command byte
    
    //Sending command to U6
    sendChars = LJUSB_Write(handle, sendBuff, 2);
    if( sendChars < 2 )
    {
        if( sendChars == 0 )
            printf("Error : write failed (StreamStop).\n");
        else
            printf("Error : did not write all of the buffer (StreamStop).\n");
        return NO;
    }
    
    //Reading response from U6
    recChars = LJUSB_Read(handle, recBuff, 4);
    if( recChars < 4 )
    {
        if( recChars == 0 )
            printf("Error : read failed (StreamStop).\n");
        else
            printf("Error : did not read all of the buffer (StreamStop).\n");
        return NO;
    }
    
    if( normalChecksum8(recBuff, 4) != recBuff[0] )
    {
        printf("Error : read buffer has bad checksum8 (StreamStop).\n");
        return NO;
    }
    
    if( recBuff[1] != (uint8)(0xB1) || recBuff[3] != (uint8)(0x00) )
    {
        printf("Error : read buffer has wrong command bytes (StreamStop).\n");
        return NO;
    }
    
    if( recBuff[2] != 0 )
    {
        printf("Errorcode # %d from StreamStop read.\n", (unsigned int)recBuff[2]);
        return NO;
    }
    
    closeUSBConnection(handle);
    return YES;
}

-(NSArray *)readStreamData{
    int recBuffSize;
    recBuffSize = 14 + (int)samplesPerPacket*2;
    uint16 voltageBytes, checksumTotal;
//    long startTime, endTime;
    NSInteger numScans = samplesPerPacket / numAnalogueChan;
    double voltages[numScans][numAnalogueChan];
    uint8 recBuff[recBuffSize];
    NSInteger currChannel = 0, scanNumber = 0;
    unsigned long recChars = 0, backLog = 0;
    BOOL autoRecoveryOn = NO;
    
//    printf("Reading Samples...\n");
    
//    startTime = getTickCount();
    //Reading stream response from U6
    recChars = LJUSB_Stream(handle, recBuff, recBuffSize);
    if( recChars < recBuffSize )
    {
        if(recChars == 0)
            printf("Error : read failed (StreamData).\n");
        else
            printf("Error : did not read all of the buffer, expected %d bytes but received %lu(StreamData).\n", recBuffSize, recChars);
        
        return nil;
    }
    
    checksumTotal = extendedChecksum16(recBuff, recBuffSize);
    if( (uint8)((checksumTotal >> 8) & 0xff) != recBuff[5] )
    {
        printf("Error : read buffer has bad checksum16(MSB) (StreamData).\n");
        return nil;
    }
    
    if( (uint8)(checksumTotal & 0xff) != recBuff[4] )
    {
        printf("Error : read buffer has bad checksum16(LSB) (StreamData).\n");
        return nil;
    }
    
    checksumTotal = extendedChecksum8(recBuff);
    if( checksumTotal != recBuff[0] )
    {
        printf("Error : read buffer has bad checksum8 (StreamData).\n");
        return nil;
    }
    
    if( recBuff[1] != (uint8)(0xF9) || recBuff[2] != 4 + samplesPerPacket || recBuff[3] != (uint8)(0xC0) )
    {
        printf("Error : read buffer has wrong command bytes (StreamData).\n");
        return nil;
    }
    
    NSInteger packetNum = (NSInteger)recBuff[10];
    if( recBuff[11] == 59 )
    {
        if( !autoRecoveryOn )
        {
            printf("\nU6 data buffer overflow detected in packet %ld.\nNow using auto-recovery and reading buffered samples.\n", packetNum);
            autoRecoveryOn = YES;
        }
    }
    else if( recBuff[11] == 60 )
    {
        printf("Auto-recovery report in packet %ld: %d scans were dropped.\nAuto-recovery is now off.\n", packetNum, recBuff[6] + recBuff[7]*256);
        autoRecoveryOn = NO;
    }
    else if( recBuff[11] != 0 )
    {
        printf("Errorcode # %d from StreamData read.\n", (unsigned int)recBuff[11]);
        return nil;
    }

/*    if( packetCounter != (int)recBuff[10] )
    {
        printf("PacketCounter (%d) does not match with with current packet count (%d)(StreamData).\n", recBuff[10], packetCounter);
        return -1;
    }*/
    
    backLog = (int)recBuff[12 + samplesPerPacket*2];
    
    for(NSInteger k = 12; k < (12 + samplesPerPacket*2); k += 2 )
    {
        voltageBytes = (uint16)recBuff[k] + (uint16)recBuff[k+1]*256;
        
        getAinVoltCalibrated(&caliInfo, 1, 0, 0, voltageBytes, &(voltages[scanNumber][currChannel]));
        
        currChannel++;
        if( currChannel >= numAnalogueChan )
        {
            currChannel = 0;
            scanNumber++;
        }
    }
    
//    endTime = getTickCount();
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for(NSInteger k = 0; k < numScans; k++ ){
        NSMutableArray *channelArray = [NSMutableArray array];
        for (NSInteger l=0; l<numAnalogueChan; l++) {
            [channelArray addObject:[NSNumber numberWithDouble:voltages[k][l]]];
        }
        [dataArray addObject:[NSArray arrayWithArray:channelArray]];
    }
    
    return [NSArray arrayWithArray:dataArray];
}

-(void)close{
    closeUSBConnection(handle);
}

@end
