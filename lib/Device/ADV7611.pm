use strict;
use warnings;
package Device::I2C::ADV7611;

# PODNAME: Device::I2C::ADV7611
# ABSTRACT: I2C interface to ADV7611 using Device::I2C
# COPYRIGHT
# VERSION

# Dependencies
use 5.010;
use Device::I2C;
use Fcntl;

use constant CTRL_IO    => 0x4c;
use constant CTRL_HDMI  => 0x34;
use constant CTRL_DPLL  => 0x3F;
use constant CTRL_CEC   => 0x40;
use constant CTRL_INFO  => 0x3E;
use constant CTRL_KSV   => 0x32;
use constant CTRL_EDID  => 0x36;
use constant CTRL_CP    => 0x22;

sub new {
    my $class = shift;
    @_ == 1
        or croak "usage: $class->new(DEVICENAME)";
    my $io = Device::I2C->new( $_[0], O_RDWR );
    if( !$io ){
        croak "Unable to open I2C Device File at $_[0]";
        return undef;
    }
    bless($io, $class);
    $io;
}

sub resetDevice {
    `echo 0 > /proc/v2r_gpio/98`;
    `echo 1 > /proc/v2r_gpio/98`;
    `echo 0 > /proc/v2r_gpio/99`;
    `echo 1 > /proc/v2r_gpio/99`;
    `echo 0 > /proc/v2r_gpio/pwctr2`;
    sleep(0.5);
    `echo 1 > /proc/v2r_gpio/pwctr2`;
}

sub checkCable {
    my ($io) = @_;
    return $io->readIO(0x6f) & 0x01;
    
}

sub writeRegister {
    my ($io, $addr, $register, $value) = @_;
    $io->select_device($addr);
    $io->writeByteData($register, $value);
}

sub readRegister {
    my ($io, $addr, $register) = @_;
    $io->select_device($addr);
    return $io->readByteData($register);
}

sub writeIO {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_IO, $register, $value);
}

sub readIO {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_IO, $register);
}

sub writeHDMI {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_HDMI, $register, $value);
}

sub readHDMI {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_HDMI, $register);
}

sub writeDPLL {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_DPLL, $register, $value);
}

sub readDPLL {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_DPLL, $register);
}

sub writeCEC {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_CEC, $register, $value);
}

sub readCEC {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_CEC, $register);
}

sub writeINFO {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_INFO, $register, $value);
}

sub readINFO {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_INFO, $register);
}
sub writeKSV {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_KSV, $register, $value);
}

sub readKSV {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_KSV, $register);
}

sub writeEDID {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_EDID, $register, $value);
}

sub readEDID {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_EDID, $register);
}

sub writeCP {
    my ($io, $register, $value) = @_;
    $io->writeRegister(CTRL_CP, $register, $value);
}

sub readCP {
    my ($io, $register) = @_;
    $io->readRegister(CTRL_CP, $register);
}

1;