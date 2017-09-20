#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist, Point

def talker(lx,ly,ax,ay):
    pub = rospy.Publisher('cmd_vel', Twist, queue_size=10)
    '''Above line says which topic and what type of data to publish'''
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # At 10 Hz
    while not rospy.is_shutdown():
	msg = Twist()	#Message type
	
	msg.linear = Point(lx,ly,0.0)		#Linear cmd_vel
	msg.angular = Point(ax,ay,0.0)	#Angular cmd_vel

	rospy.loginfo(msg)
        pub.publish(msg)
	rate.sleep()	#sleep for rate specified earlier

if __name__ == '__main__':
    try:
        talker(0.0,0.0,0.0,0.0)
    except rospy.ROSInterruptException:
	pass
