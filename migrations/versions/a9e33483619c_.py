"""empty message

Revision ID: a9e33483619c
Revises: 
Create Date: 2020-04-07 03:20:39.200530

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'a9e33483619c'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('points',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('latitude', sa.Float(), nullable=False),
    sa.Column('longtitude', sa.Float(), nullable=False),
    sa.Column('created_at', sa.DateTime(), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('users',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('username', sa.String(length=255), nullable=False),
    sa.Column('encrypted_password', sa.String(length=255), nullable=False),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.Column('age', sa.Integer(), nullable=True),
    sa.Column('height', sa.Integer(), nullable=True),
    sa.Column('weight', sa.Integer(), nullable=True),
    sa.Column('created_at', sa.DateTime(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('username')
    )
    op.create_table('routes',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('user_id', sa.Integer(), nullable=False),
    sa.Column('distance', sa.Integer(), nullable=False),
    sa.Column('polyline', sa.String(length=255), nullable=False),
    sa.Column('startPos', sa.Integer(), nullable=False),
    sa.Column('endPos', sa.Integer(), nullable=False),
    sa.Column('purpose', sa.String(length=255), nullable=False),
    sa.Column('calories', sa.Integer(), nullable=True),
    sa.Column('ascent', sa.Integer(), nullable=False),
    sa.Column('descent', sa.Integer(), nullable=False),
    sa.Column('created_at', sa.DateTime(), nullable=True),
    sa.ForeignKeyConstraint(['endPos'], ['points.id'], ),
    sa.ForeignKeyConstraint(['startPos'], ['points.id'], ),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('routes')
    op.drop_table('users')
    op.drop_table('points')
    # ### end Alembic commands ###