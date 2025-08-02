# 2D column space
A = [1 2 1.5; 1 -1 0; 0.2 0.5 0.35]
U = qr(A).Q[:,1:rank(A)]

# 1D left null space
y = qr(A).Q[:,3]#(I - U*U')*rand(3)
y = 2.5y/norm(y)

l = 1.5*norm(A)

set_theme!(theme_black())
fig = Figure(resolution=(1800,1200),fontsize=50)
ax = Axis3(fig[1,1],viewmode=:fit,limits=(-l,l,-l,l,-l,l),aspect=:data)
meshscatter!([0],[0],[0],color=:white,shading=false)
vectors!(A,color=:yellow)
vectors!(2*U,color=:orange)
vector!(y,color=:red)
plane!(A, color=(:cyan,0.6))

# 1D column space
A = [1;1;1]*[1 0.5 1.5]
cdim = rank(A)
U = qr(A).Q[:,1:cdim]

# 2D left null space
ndim = size(A,1)-cdim
B = (I - U*U')*rand(3,ndim)

l = 1.5*norm(A)
B = B*l

set_theme!(theme_black())
fig = Figure(resolution=(1800,1200),fontsize=50)
ax = Axis3(fig[1,1],viewmode=:fit,limits=(-l,l,-l,l,-l,l),aspect=:data)
meshscatter!([0],[0],[0],color=:white,shading=false)
vectors!(B,color=:red)
vectors!(A,color=:yellow)
plane!(B, l, color=(:cyan,0.6))